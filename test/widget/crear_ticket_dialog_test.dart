import 'package:desk_sla_app/models/desk.model.dart' as models;
import 'package:desk_sla_app/widgets/crear_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

models.Usuario _usuario() {
  return models.Usuario(
    id: 1,
    Nombre: 'Usuario Final',
    DocumentoIdentidad: 1000,
    Correo: 'usuario@example.com',
    Rol: 'Solicitante',
    pendingSync: false,
  );
}

Future<void> _pumpDialog(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CrearTicketDialog(usuario: _usuario()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('WT-01 formulario de crear ticket muestra serial y categoria', (tester) async {
    await _pumpDialog(tester);

    expect(find.text('Crear ticket'), findsOneWidget);
    expect(find.text('Serial del equipo'), findsOneWidget);
    expect(find.text('Categoría'), findsOneWidget);
  });

  testWidgets('WT-02 valida serial vacio cuando se intenta crear el ticket', (tester) async {
    await _pumpDialog(tester);

    await tester.tap(find.text('Crear'));
    await tester.pumpAndSettle();

    expect(find.text('El serial no puede estar vacío.'), findsOneWidget);
  });

  testWidgets('WT-03 asigna prioridad alta al elegir una categoria critica', (tester) async {
    await _pumpDialog(tester);

    await tester.enterText(find.byType(TextField), 'LAP-001');
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fallas de hardware').last);
    await tester.pumpAndSettle();

    expect(find.text('Prioridad asignada: Alta'), findsOneWidget);
  });

  testWidgets('WT-04 valida categoria vacia cuando se intenta crear el ticket', (tester) async {
    await _pumpDialog(tester);

    await tester.enterText(find.byType(TextField), 'PC-002');
    await tester.tap(find.text('Crear'));
    await tester.pumpAndSettle();

    expect(find.text('Selecciona una categoría.'), findsOneWidget);
  });
}