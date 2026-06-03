import 'dart:async';

import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/desk.model.dart' as models;
import '../services/auth_service.dart';
import '../services/ticket_remote_service.dart';
import '../services/ticket_repository.dart';
import 'login.pages.dart';

class TecnicoPage extends StatefulWidget {
  final models.Tecnico tecnico;

  const TecnicoPage({
    super.key,
    required this.tecnico,
  });

  @override
  State<TecnicoPage> createState() => _TecnicoPageState();
}

class _TecnicoPageState extends State<TecnicoPage> {
  final AppDatabase _db = AppDatabase();
  final _authService = FirebaseAuthService();
  final _remoteService = TicketRemoteService();
  late final TicketRepository _repository = TicketRepository(
    db: _db,
    remoteService: _remoteService,
    authService: _authService,
  );

  List<models.Ticket> _tickets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarTickets();
  }

  @override
  void dispose() {
    unawaited(_db.close());
    super.dispose();
  }

  models.Usuario _asUsuarioActor() {
    return models.Usuario(
      id: widget.tecnico.id,
      Nombre: widget.tecnico.Nombre,
      DocumentoIdentidad: widget.tecnico.DocumentoIdentidad,
      Correo: widget.tecnico.Correo,
      Rol: 'tecnico',
      pendingSync: false,
    );
  }

  Future<void> _cargarTickets() async {
    setState(() => _isLoading = true);

    try {
      await _repository.syncAll();
      final tickets = await _repository.getAllTickets();

      setState(() {
        _tickets = tickets.where((t) => t.tecnico.id == widget.tecnico.id).toList();
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  bool _isClosed(models.Ticket ticket) {
    return ticket.Estado.trim() == 'Cerrado';
  }

  Future<void> _editarComentario(models.Ticket ticket) async {
    if (_isClosed(ticket)) return;

    final controller = TextEditingController(
      text: ticket.comentario.Contenido,
    );

    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar comentario del ticket #${ticket.id}'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Comentario',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    if (resultado != true) {
      controller.dispose();
      return;
    }

    try {
      final contenidoNuevo = controller.text.trim();

      if (contenidoNuevo.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El comentario no puede estar vacío'),
            backgroundColor: Colors.orange,
          ),
        );
        controller.dispose();
        return;
      }

      final comentario = ticket.comentario.copyWith(
        Contenido: contenidoNuevo,
        pendingSync: true,
      );

      await _repository.saveComentario(
        comentario,
        ticketId: ticket.id,
      );

      await _cargarTickets();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comentario actualizado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar comentario: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  Future<void> _marcarComoSolucionado(models.Ticket ticket) async {
    if (_isClosed(ticket)) return;

    final controller = TextEditingController(text: ticket.comentario.Contenido);

    final comentario = await showDialog<String?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Marcar ticket #${ticket.id} como solucionado'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Comentario de solución',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (comentario == null) return;
    if (comentario.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes escribir un comentario de solución'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final actor = _asUsuarioActor();
      var actualizado = ticket.copyWith(
        comentario: ticket.comentario.copyWith(
          Contenido: comentario,
          pendingSync: true,
        ),
      );

      final status = actualizado.Estado.trim();

      if (status == 'Pendiente') {
        actualizado = await _repository.changeTicketStatus(
          actor: actor,
          ticket: actualizado,
          nextStatus: 'Asignado',
          solutionComment: comentario,
        );
      }

      actualizado = await _repository.changeTicketStatus(
        actor: actor,
        ticket: actualizado,
        nextStatus: 'Cerrado',
        solutionComment: comentario,
      );

      await _cargarTickets();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket marcado como solucionado y cerrado'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No fue posible cerrar el ticket: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Color _prioridadColor(String prioridad) {
    switch (prioridad.trim()) {
      case 'Alta':
        return Colors.red;
      case 'Media':
        return Colors.orange;
      case 'Baja':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _estadoColor(String estado) {
    switch (estado) {
      case 'Pendiente':
        return Colors.orange;
      case 'Asignado':
        return Colors.blueAccent;
      case 'Vencido':
        return Colors.red;
      case 'Cerrado':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: Text(
          'Tickets de ${widget.tecnico.Nombre}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF5C6BC0),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await _authService.logout();
              } catch (_) {}
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tickets.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.engineering, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No tienes tickets asignados',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _cargarTickets,
                  child: ListView.builder(
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = _tickets[index];
                      final isClosed = _isClosed(ticket);

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '#${ticket.id}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _estadoColor(ticket.Estado)
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      ticket.Estado,
                                      style: TextStyle(
                                        color: _estadoColor(ticket.Estado),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _prioridadColor(ticket.Prioridad)
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      ticket.Prioridad,
                                      style: TextStyle(
                                        color: _prioridadColor(ticket.Prioridad),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Serial: ${ticket.SerialEquipo}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Categoría: ${ticket.categoria.Nombre}'),
                              const SizedBox(height: 4),
                              Text('Usuario: ${ticket.usuario.Nombre}'),
                              const SizedBox(height: 4),
                              Text('Fecha: ${_formatFecha(ticket.FechaCreacion)}'),
                              const SizedBox(height: 12),
                              const Text(
                                'Comentario',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4F6FB),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Text(
                                  ticket.comentario.Contenido.isNotEmpty
                                      ? ticket.comentario.Contenido
                                      : 'Sin comentario',
                                  style: TextStyle(
                                    color: ticket.comentario.Contenido.isNotEmpty
                                        ? Colors.black87
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: isClosed
                                          ? null
                                          : () => _editarComentario(ticket),
                                      icon: const Icon(Icons.edit_note),
                                      label: const Text('Editar comentario'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: FilledButton.icon(
                                      onPressed: isClosed
                                          ? null
                                          : () => _marcarComoSolucionado(ticket),
                                      icon: const Icon(Icons.check_circle_outline),
                                      label: const Text('Solucionado'),
                                    ),
                                  ),
                                ],
                              ),
                              if (isClosed) ...[
                                const SizedBox(height: 10),
                                const Text(
                                  'Este ticket está cerrado y no puede editarse.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}