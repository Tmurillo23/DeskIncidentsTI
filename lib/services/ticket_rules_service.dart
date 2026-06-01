import '../models/desk.model.dart' as models;

class TicketRulesService {
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

  Duration? parseSlaDuration(String rawValue) {
    final text = rawValue.trim().toLowerCase();
    if (text.isEmpty) return null;

    final hoursMatch = RegExp(r'^(\d+)\s*h').firstMatch(text);
    if (hoursMatch != null) {
      return Duration(hours: int.parse(hoursMatch.group(1)!));
    }

    final minutesMatch = RegExp(r'^(\d+)\s*m').firstMatch(text);
    if (minutesMatch != null) {
      return Duration(minutes: int.parse(minutesMatch.group(1)!));
    }

    final numeric = int.tryParse(text);
    if (numeric != null) {
      return Duration(minutes: numeric);
    }

    return null;
  }

  DateTime? calculateSlaDeadline(models.Ticket ticket) {
    final duration = parseSlaDuration(ticket.categoria.TiempoRespuesta);
    if (duration == null) return null;
    return ticket.FechaCreacion.add(duration);
  }

  bool isTicketOverdue(models.Ticket ticket) {
    final status = ticket.Estado.trim().toLowerCase();
    if (status == 'cerrado' || status == 'vencido') {
      return false;
    }

    final deadline = calculateSlaDeadline(ticket);
    if (deadline == null) return false;

    return DateTime.now().isAfter(deadline);
  }

  bool canTransition(String currentStatus, String nextStatus) {
    final current = currentStatus.trim().toLowerCase();
    final next = nextStatus.trim().toLowerCase();

    const allowedTransitions = <String, Set<String>>{
      'pendiente': {'asignado', 'vencido'},
      'asignado': {'en proceso', 'vencido'},
      'en proceso': {'resuelto', 'vencido'},
      'resuelto': {'cerrado'},
      'cerrado': {},
      'vencido': {},
    };

    return allowedTransitions[current]?.contains(next) ?? false;
  }

  bool requiresSolutionCommentForClose(models.Ticket ticket, String? comment) {
    final currentComment = ticket.comentario.Contenido.trim();
    final incomingComment = (comment ?? '').trim();
    return currentComment.isNotEmpty || incomingComment.isNotEmpty;
  }
}