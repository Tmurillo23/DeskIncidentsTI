import 'package:flutter/material.dart';
import '../data/app_database.dart';
import '../models/desk.model.dart' as models;

class AgregarTec {
  final String Nombre;
  final int DocumentoIdentidad;
  final String Correo;

  const AgregarTec({
    required this.Nombre,
    required this.DocumentoIdentidad,
    required this.Correo,
  });
}

class AgregarTecDialog extends StatefulWidget {
  const AgregarTecDialog({super.key});

  @override
  State<AgregarTecDialog> createState() => _AgregarTecDialogState();
}

class _AgregarTecDialogState extends State<AgregarTecDialog> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _nombreError;
  String? _documentoError;
  String? _correoError;
  String? _passwordError;
  bool _isLoading = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _documentoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final nombre = _nombreController.text.trim();
    final correo = _correoController.text.trim();
    final documento = _documentoController.text.trim();
    final password = _passwordController.text;

    bool hasError = false;

    if (nombre.isEmpty) {
      setState(() => _nombreError = 'El nombre no puede estar vacío.');
      hasError = true;
    }
    if (documento.isEmpty) {
      setState(() => _documentoError = 'El documento no puede estar vacío.');
      hasError = true;
    }
    if (correo.isEmpty) {
      setState(() => _correoError = 'El correo no puede estar vacío.');
      hasError = true;
    }
    if (password.isEmpty) {
      setState(() => _passwordError = 'La contraseña no puede estar vacía.');
      hasError = true;
    } else if (password.length < 6) {
      setState(() => _passwordError = 'La contraseña debe tener al menos 6 caracteres.');
      hasError = true;
    }

    if (hasError) return;

    setState(() => _isLoading = true);

    try {
      final db = AppDatabase();

      await db.insertTecnico(
        models.Tecnico(
          id: 0,
          Nombre: nombre,
          Correo: correo,
          DocumentoIdentidad: int.tryParse(documento) ?? 0,
          Password: password,
          pendingSync: true,
        ),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Técnico agregado correctamente'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop(
        AgregarTec(
          Nombre: nombre,
          Correo: correo,
          DocumentoIdentidad: int.tryParse(documento) ?? 0,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar técnico'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nombreController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Nombre',
              errorText: _nombreError,
            ),
            onChanged: (_) {
              if (_nombreError != null) setState(() => _nombreError = null);
            },
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _documentoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Documento de Identidad',
              errorText: _documentoError,
            ),
            onChanged: (_) {
              if (_documentoError != null) {
                setState(() => _documentoError = null);
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _correoController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Correo',
              errorText: _correoError,
            ),
            onChanged: (_) {
              if (_correoError != null) setState(() => _correoError = null);
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              errorText: _passwordError,
            ),
            onChanged: (_) {
              if (_passwordError != null) {
                setState(() => _passwordError = null);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _save,
          child: _isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Guardar'),
        ),
      ],
    );
  }
}