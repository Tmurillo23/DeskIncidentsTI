import 'package:desk_sla_app/models/desk.model.dart' as models;
import 'package:flutter_test/flutter_test.dart';

models.Usuario _usuario() => models.Usuario(
      id: 1,
      Nombre: 'Maria Perez',
      DocumentoIdentidad: 123456,
      Correo: 'maria@example.com',
      Rol: 'Solicitante',
      pendingSync: true,
    );

models.Tecnico _tecnico() => models.Tecnico(
      id: 2,
      Nombre: 'Juan Soporte',
      DocumentoIdentidad: 654321,
      Correo: 'juan@example.com',
      Password: 'secret',
      pendingSync: true,
    );

models.Categoria _categoria() => models.Categoria(
      id: 3,
      Nombre: 'Red',
      Descripcion: 'Incidente critico de red',
      TiempoRespuesta: '2h',
      pendingSync: true,
    );

models.Comentario _comentario() => models.Comentario(
      id: 4,
      Contenido: 'Sin acceso a internet',
      pendingSync: true,
    );

void main() {
  test('copyWith preserves fields and updates pendingSync', () {
    final usuario = _usuario();
    final updated = usuario.copyWith(pendingSync: false, Nombre: 'Maria Lopez');

    expect(updated.id, usuario.id);
    expect(updated.Nombre, 'Maria Lopez');
    expect(updated.pendingSync, isFalse);
    expect(updated.Correo, usuario.Correo);
  });

  test('ticket round trips through firestore map', () {
    final ticket = models.Ticket(
      id: 10,
      Estado: 'Pendiente',
      FechaCreacion: DateTime(2026, 1, 2, 10, 30),
      Prioridad: 'Alta',
      SerialEquipo: 'PC-001',
      pendingSync: true,
      tecnico: _tecnico(),
      categoria: _categoria(),
      usuario: _usuario(),
      comentario: _comentario(),
    );

    final firestoreMap = ticket.toFirestore();
    final restored = models.Ticket.fromFirestore(firestoreMap, id: 10);

    expect(firestoreMap['estado'], 'Pendiente');
    expect(firestoreMap['serialEquipo'], 'PC-001');
    expect(restored.id, 10);
    expect(restored.Estado, 'Pendiente');
    expect(restored.Prioridad, 'Alta');
    expect(restored.SerialEquipo, 'PC-001');
    expect(restored.tecnico.id, 2);
    expect(restored.categoria.id, 3);
    expect(restored.usuario.id, 1);
    expect(restored.comentario.id, 4);
  });
}