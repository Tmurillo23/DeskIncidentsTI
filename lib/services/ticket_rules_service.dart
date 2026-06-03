import '../models/desk.model.dart' as models;

class TicketRulesService {
  /// Tiempo máximo de atención global para todos los tickets.
  static const String globalMaxAttentionTime = '10m';

  static const String statusPendiente = 'Pendiente';
  static const String statusAsignado = 'Asignado';
  static const String statusVencido = 'Vencido';
  static const String statusCerrado = 'Cerrado';

  bool isSolicitante(models.Usuario usuario) {
    return usuario.Rol.trim().toLowerCase() == 'solicitante';
  }

  bool isTecnico(models.Usuario usuario) {
    return usuario.Rol.trim().toLowerCase() == 'tecnico';
  }

  bool isAdmin(models.Usuario usuario) {
    final role = usuario.Rol.trim().toLowerCase();
    return role == 'administrador' || role == 'admin';
  }

  bool canViewTicket(models.Usuario usuario, models.Ticket ticket) {
    if (isAdmin(usuario)) return true;
    if (isSolicitante(usuario)) return ticket.usuario.id == usuario.id;
    if (isTecnico(usuario)) return ticket.tecnico.id == usuario.id;
    return false;
  }

  bool canCreateTicket(models.Usuario usuario) => isSolicitante(usuario);

  bool canReassignTicket(models.Usuario usuario) => isAdmin(usuario);

  bool canResolveTicket(models.Usuario usuario, models.Ticket ticket) {
    return isAdmin(usuario) ||
        (isTecnico(usuario) && ticket.tecnico.id == usuario.id);
  }

  bool canCloseTicket(
    models.Usuario usuario,
    models.Ticket ticket, {
    String? solutionComment,
  }) {
    final allowed = canResolveTicket(usuario, ticket);
    final hasComment =
        (solutionComment ?? ticket.comentario.Contenido).trim().isNotEmpty;
    return allowed && hasComment;
  }

  bool isCriticalCategory(models.Categoria categoria) {
    final name = categoria.Nombre.toLowerCase();
    final description = categoria.Descripcion.toLowerCase();
    final response = categoria.TiempoRespuesta.toLowerCase();

    return name.contains('crit') ||
        description.contains('crit') ||
        response.contains('crit') ||
        response.contains('alta');
  }

  String determineInitialPriority(models.Categoria categoria) {
    return isCriticalCategory(categoria) ? 'Alta' : 'Media';
  }

  Duration? parseGlobalMaxAttentionTime() {
    final text = globalMaxAttentionTime.trim().toLowerCase();
    if (text.isEmpty) return null;

    final hoursMatch = RegExp(r'^(\d+)\s*h$').firstMatch(text);
    if (hoursMatch != null) {
      return Duration(hours: int.parse(hoursMatch.group(1)!));
    }

    final minutesMatch = RegExp(r'^(\d+)\s*m$').firstMatch(text);
    if (minutesMatch != null) {
      return Duration(minutes: int.parse(minutesMatch.group(1)!));
    }

    final secondsMatch = RegExp(r'^(\d+)\s*s$').firstMatch(text);
    if (secondsMatch != null) {
      return Duration(seconds: int.parse(secondsMatch.group(1)!));
    }

    final numeric = int.tryParse(text);
    if (numeric != null) {
      return Duration(seconds: numeric);
    }

    return null;
  }

  DateTime? calculateSlaDeadline(models.Ticket ticket) {
    final duration = parseGlobalMaxAttentionTime();
    if (duration == null) return null;
    return ticket.FechaCreacion.add(duration);
  }

  bool isTicketOverdue(models.Ticket ticket) {
    final status = ticket.Estado.trim();
    if (status == statusCerrado || status == statusVencido) {
      return false;
    }

    final deadline = calculateSlaDeadline(ticket);
    if (deadline == null) return false;

    return DateTime.now().isAfter(deadline);
  }

  bool canTransition(String currentStatus, String nextStatus) {
    const allowedTransitions = <String, Set<String>>{
      'Pendiente': {'Asignado'},
      'Asignado': {'Vencido', 'Cerrado'},
      'Vencido': {'Asignado', 'Cerrado'},
      'Cerrado': {},
    };

    return allowedTransitions[currentStatus.trim()]?.contains(nextStatus.trim()) ??
        false;
  }

  bool requiresSolutionCommentForClose(models.Ticket ticket, String? comment) {
    final currentComment = ticket.comentario.Contenido.trim();
    final incomingComment = (comment ?? '').trim();
    return currentComment.isNotEmpty || incomingComment.isNotEmpty;
  }

  bool isClosedStatus(String status) {
    return status.trim() == statusCerrado;
  }
}