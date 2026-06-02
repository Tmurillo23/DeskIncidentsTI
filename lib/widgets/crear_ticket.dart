import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/desk.model.dart' as models;
import '../services/auth_service.dart';
import '../services/ticket_remote_service.dart';
import '../services/ticket_repository.dart';

// Categorías con su prioridad por defecto
const Map<String, String> _categoriasPrioridad = {
  'Fallas de hardware': 'Alta',
  'Incidentes de seguridad': 'Alta',
  'Errores de software': 'Media',
  'Problemas de conectividad': 'Media',
  'Provisionamiento de equipos': 'Baja',
  'Instalación y licencias': 'Baja',
  'Mantenimiento y reubicación': 'Baja',
};

class CrearTicketDialog extends StatefulWidget {
  final models.Usuario usuario;

  const CrearTicketDialog({
    super.key,
    required this.usuario,
  });

  @override
  State<CrearTicketDialog> createState() => _CrearTicketDialogState();
}

class _CrearTicketDialogState extends State<CrearTicketDialog> {
  final AppDatabase _db = AppDatabase();
  late final TicketRepository _repository = TicketRepository(
    db: _db,
    remoteService: TicketRemoteService(),
    authService: FirebaseAuthService(),
  );

  final TextEditingController _serialController = TextEditingController();

  String? _serialError;
  String? _categoriaError;
  String? _categoriaSeleccionada;
  String _prioridadAsignada = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _serialController.dispose();
    _db.close();
    super.dispose();
  }

  void _onCategoriaChanged(String? categoria) {
    setState(() {
      _categoriaSeleccionada = categoria;
      _categoriaError = null;
      _prioridadAsignada = _categoriasPrioridad[categoria] ?? '';
    });
  }

  Future<void> _save() async {
    final serial = _serialController.text.trim();

    bool hasError = false;
    if (serial.isEmpty) {
      setState(() => _serialError = 'El serial no puede estar vacío.');
      hasError = true;
    }
    if (_categoriaSeleccionada == null) {
      setState(() => _categoriaError = 'Selecciona una categoría.');
      hasError = true;
    }
    if (hasError) return;

    setState(() => _isLoading = true);

    try {
      final categorias = await _repository.getAllCategorias();
      final categoriaExistente = categorias
          .where((c) => c.Nombre == _categoriaSeleccionada)
          .toList();

      models.Categoria categoria;
      if (categoriaExistente.isNotEmpty) {
        categoria = categoriaExistente.first;
      } else {
        categoria = await _repository.saveCategoria(
          models.Categoria(
            id: 0,
            Nombre: _categoriaSeleccionada!,
            Descripcion: '',
            TiempoRespuesta: _prioridadAsignada,
            pendingSync: true,
          ),
        );
      }

      final tecnicoVacio = models.Tecnico(
        id: 0,
        Nombre: 'Pendiente',
        DocumentoIdentidad: 0,
        Correo: '',
        Password: '',
        pendingSync: false,
      );

      final ticketCreado = await _repository.createTicket(
        usuario: widget.usuario,
        categoria: categoria,
        tecnico: tecnicoVacio,
        serialEquipo: serial,
        comentarioInicial: '',
      );

      await _repository.saveTicket(
        ticketCreado.copyWith(
          Prioridad: _prioridadAsignada.isNotEmpty
              ? _prioridadAsignada
              : ticketCreado.Prioridad,
        ),
      );

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear ticket: $e'),
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
      title: const Text('Crear ticket'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _serialController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Serial del equipo',
              prefixIcon: const Icon(Icons.computer),
              errorText: _serialError,
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) {
              if (_serialError != null) setState(() => _serialError = null);
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _categoriaSeleccionada,
            decoration: const InputDecoration(
              labelText: 'Categoría',
              prefixIcon: Icon(Icons.category_outlined),
              border: OutlineInputBorder(),
            ),
            items: _categoriasPrioridad.keys
                .map(
                  (categoria) => DropdownMenuItem(
                    value: categoria,
                    child: Text(
                      categoria,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                )
                .toList(),
            onChanged: _onCategoriaChanged,
          ),
          if (_categoriaError != null) ...[
            const SizedBox(height: 8),
            Text(
              _categoriaError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 16),
          if (_prioridadAsignada.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _prioridadColor(_prioridadAsignada).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _prioridadColor(_prioridadAsignada).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flag,
                    size: 16,
                    color: _prioridadColor(_prioridadAsignada),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Prioridad asignada: $_prioridadAsignada',
                    style: TextStyle(
                      color: _prioridadColor(_prioridadAsignada),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
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
              : const Text('Crear'),
        ),
      ],
    );
  }

  Color _prioridadColor(String prioridad) {
    switch (prioridad.toLowerCase()) {
      case 'alta':
        return Colors.red;
      case 'media':
        return Colors.orange;
      case 'baja':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}