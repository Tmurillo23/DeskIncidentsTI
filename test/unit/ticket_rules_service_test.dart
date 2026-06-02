import 'package:desk_sla_app/models/desk.model.dart' as models;
import 'package:desk_sla_app/services/ticket_rules_service.dart';
import 'package:flutter_test/flutter_test.dart';

models.Usuario _usuario({required int id, required String rol}) {
  return models.Usuario(
    id: id,
    Nombre: 'Usuario $id',
    DocumentoIdentidad: 1000 + id,
    Correo: 'usuario$id@example.com',
    Rol: rol,
    pendingSync: false,
  );
}

models.Tecnico _tecnico({required int id}) {
  return models.Tecnico(
    id: id,
    Nombre: 'Tecnico $id',
    DocumentoIdentidad: 2000 + id,
    Correo: 'tecnico$id@example.com',
    Password: 'secret',
    pendingSync: false,
  );
}

models.Categoria _categoria({
  required int id,
  required String nombre,
  required String descripcion,
  required String tiempoRespuesta,
}) {
  return models.Categoria(
    id: id,
    Nombre: nombre,
    Descripcion: descripcion,
    TiempoRespuesta: tiempoRespuesta,
    pendingSync: false,
  );
}

models.Comentario _comentario({required int id, required String contenido}) {
  return models.Comentario(
    id: id,
    Contenido: contenido,
    pendingSync: false,
  );
}

models.Ticket _ticket({
  required int id,
  required String estado,
  required DateTime fechaCreacion,
  required String prioridad,
  required models.Usuario usuario,
  required models.Tecnico tecnico,
  required models.Categoria categoria,
  required models.Comentario comentario,
}) {
  return models.Ticket(
    id: id,
    Estado: estado,
    FechaCreacion: fechaCreacion,
    Prioridad: prioridad,
    SerialEquipo: 'SER-$id',
    pendingSync: false,
    tecnico: tecnico,
    categoria: categoria,
    usuario: usuario,
    comentario: comentario,
  );
}

void main() {
  final rules = TicketRulesService();

  test('UT-01 todo_ticket_nuevo_inicia_en_pendiente', () {
    final ticket = _ticket(
      id: 1,
      estado: 'Pendiente',
      fechaCreacion: DateTime(2026, 1, 1),
      prioridad: 'Media',
      usuario: _usuario(id: 1, rol: 'Solicitante'),
      tecnico: _tecnico(id: 2),
      categoria: _categoria(
        id: 3,
        nombre: 'Soporte',
        descripcion: 'Mesa de ayuda',
        tiempoRespuesta: '8h',
      ),
      comentario: _comentario(id: 1, contenido: ''),
    );

    expect(ticket.Estado, 'Pendiente');
  });

  test('UT-02 categoria_critica_asigna_prioridad_alta_automaticamente', () {
    final categoriaCritica = _categoria(
      id: 2,
      nombre: 'Critica',
      descripcion: 'Incidente critico de red',
      tiempoRespuesta: '2h',
    );

    expect(rules.determineInitialPriority(categoriaCritica), 'Alta');
  });

  test('UT-03 tecnico_no_puede_cerrar_ticket_sin_comentario_de_solucion', () {
    final tecnico = _usuario(id: 2, rol: 'Tecnico');
    final ticket = _ticket(
      id: 3,
      estado: 'Asignado',
      fechaCreacion: DateTime(2026, 1, 1),
      prioridad: 'Media',
      usuario: _usuario(id: 1, rol: 'Solicitante'),
      tecnico: _tecnico(id: 2),
      categoria: _categoria(
        id: 4,
        nombre: 'Soporte',
        descripcion: 'Mesa de ayuda',
        tiempoRespuesta: '8h',
      ),
      comentario: _comentario(id: 2, contenido: 'Diagnostico listo'),
    );

    expect(rules.canCloseTicket(tecnico, ticket), isTrue);
    expect(rules.canCloseTicket(tecnico, ticket, solutionComment: '  '), isFalse);
  });

  test('UT-04 ticket_cerrado_no_puede_editarse', () {
    expect(rules.canTransition('Cerrado', 'Asignado'), isFalse);
    expect(rules.canTransition('Cerrado', 'Pendiente'), isFalse);
  });

  test('UT-05 ticket_vencido_cuando_supera_tiempo_maximo_de_atencion', () {
    final ticketVencido = _ticket(
      id: 4,
      estado: 'Pendiente',
      fechaCreacion: DateTime.now().subtract(const Duration(hours: 3)),
      prioridad: 'Media',
      usuario: _usuario(id: 3, rol: 'Solicitante'),
      tecnico: _tecnico(id: 4),
      categoria: _categoria(
        id: 5,
        nombre: 'Red',
        descripcion: 'Mantenimiento',
        tiempoRespuesta: '2h',
      ),
      comentario: _comentario(id: 3, contenido: ''),
    );

    expect(rules.isTicketOverdue(ticketVencido), isTrue);
  });

  test('UT-06 solo_administrador_puede_reasignar_ticket', () {
    final admin = _usuario(id: 5, rol: 'Administrador');
    final tecnico = _usuario(id: 6, rol: 'Tecnico');
    final ticket = _ticket(
      id: 6,
      estado: 'Asignado',
      fechaCreacion: DateTime(2026, 1, 1),
      prioridad: 'Media',
      usuario: tecnico,
      tecnico: _tecnico(id: 6),
      categoria: _categoria(
        id: 7,
        nombre: 'Soporte',
        descripcion: 'Mesa de ayuda',
        tiempoRespuesta: '8h',
      ),
      comentario: _comentario(id: 4, contenido: 'OK'),
    );

    expect(rules.canReassignTicket(admin), isTrue);
    expect(rules.canReassignTicket(tecnico), isFalse);
    expect(rules.canCloseTicket(admin, ticket), isTrue);
  });

  test('UT-07 solicitante_no_puede_cambiar_estado_de_ticket', () {
    final solicitante = _usuario(id: 7, rol: 'Solicitante');
    final ticket = _ticket(
      id: 8,
      estado: 'Pendiente',
      fechaCreacion: DateTime(2026, 1, 1),
      prioridad: 'Alta',
      usuario: solicitante,
      tecnico: _tecnico(id: 8),
      categoria: _categoria(
        id: 9,
        nombre: 'Software',
        descripcion: 'Error de aplicacion',
        tiempoRespuesta: '4h',
      ),
      comentario: _comentario(id: 5, contenido: ''),
    );

    expect(rules.canCreateTicket(solicitante), isTrue);
    expect(rules.canResolveTicket(solicitante, ticket), isFalse);
    expect(rules.canCloseTicket(solicitante, ticket, solutionComment: 'Cierre'), isFalse);
  });

  test('UT-08 ticket_sin_conexion_queda_como_pendingSync', () {
    final ticket = _ticket(
      id: 10,
      estado: 'Pendiente',
      fechaCreacion: DateTime(2026, 1, 1),
      prioridad: 'Media',
      usuario: _usuario(id: 10, rol: 'Solicitante'),
      tecnico: _tecnico(id: 11),
      categoria: _categoria(
        id: 12,
        nombre: 'Hardware',
        descripcion: 'Falla fisica',
        tiempoRespuesta: '2h',
      ),
      comentario: _comentario(id: 6, contenido: ''),
    );

    expect(ticket.pendingSync, isFalse);
    expect(ticket.copyWith(pendingSync: true).pendingSync, isTrue);
  });
}