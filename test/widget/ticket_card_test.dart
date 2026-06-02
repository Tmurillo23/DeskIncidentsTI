import 'package:desk_sla_app/models/desk.model.dart' as models;
import 'package:desk_sla_app/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

models.Ticket _ticket({String comentario = ''}) {
  return models.Ticket(
    id: 15,
    Estado: 'Pendiente',
    FechaCreacion: DateTime(2026, 1, 1),
    Prioridad: 'Alta',
    SerialEquipo: 'LAP-123',
    pendingSync: true,
    tecnico: models.Tecnico(
      id: 2,
      Nombre: 'Tecnico Asignado',
      DocumentoIdentidad: 2000,
      Correo: 'tecnico@example.com',
      Password: 'secret',
      pendingSync: false,
    ),
    categoria: models.Categoria(
      id: 3,
      Nombre: 'Hardware',
      Descripcion: 'Falla de laptop',
      TiempoRespuesta: '2h',
      pendingSync: false,
    ),
    usuario: models.Usuario(
      id: 1,
      Nombre: 'Usuario Final',
      DocumentoIdentidad: 1000,
      Correo: 'usuario@example.com',
      Rol: 'Solicitante',
      pendingSync: false,
    ),
    comentario: models.Comentario(
      id: 4,
      Contenido: comentario,
      pendingSync: false,
    ),
  );
}

void main() {
  testWidgets('WT-05 renderiza el resumen del ticket', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TicketCard(ticket: _ticket()),
        ),
      ),
    );

    expect(find.text('#15'), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);
    expect(find.text('Alta'), findsOneWidget);
    expect(find.text('Serial: LAP-123'), findsOneWidget);
    expect(find.text('Tecnico Asignado'), findsOneWidget);
    expect(find.text('Usuario Final'), findsOneWidget);
    expect(find.text('Hardware'), findsOneWidget);
  });

  testWidgets('WT-06 muestra comnetario solo cuando el ticket tiene uno', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TicketCard(
            ticket: _ticket(comentario: 'Requiere reemplazo de pantalla'),
          ),
        ),
      ),
    );

    expect(find.text('Requiere reemplazo de pantalla'), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TicketCard(ticket: _ticket()),
        ),
      ),
    );

    expect(find.text('Requiere reemplazo de pantalla'), findsNothing);
  });
}