// lib/widgets/asignar_tec_card.dart
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/desk.model.dart' as models;

class AsignarTecCard extends StatefulWidget {
  final models.Ticket ticket;
  final VoidCallback onAsignado; // ✅ callback para recargar la lista

  const AsignarTecCard({
    super.key,
    required this.ticket,
    required this.onAsignado,
  });

  @override
  State<AsignarTecCard> createState() => _AsignarTecCardState();
}

class _AsignarTecCardState extends State<AsignarTecCard> {
  List<models.Tecnico> _tecnicos = [];
  models.Tecnico? _tecnicoSeleccionado;
  bool _isLoading = false;
  bool _cargandoTecnicos = true;

  @override
  void initState() {
    super.initState();
    _cargarTecnicos();
  }

  Future<void> _cargarTecnicos() async {
    try {
      final tecnicos = await appDatabase.getAllTecnicos();
      setState(() {
        _tecnicos = tecnicos;
        // ✅ si ya tiene técnico asignado lo preselecciona
        if (widget.ticket.tecnico.id != 0) {
          _tecnicoSeleccionado = tecnicos.firstWhere(
            (t) => t.id == widget.ticket.tecnico.id,
            orElse: () => tecnicos.first,
          );
        }
        _cargandoTecnicos = false;
      });
    } catch (e) {
      setState(() => _cargandoTecnicos = false);
    }
  }

  Future<void> _asignar() async {
    if (_tecnicoSeleccionado == null) return;

    setState(() => _isLoading = true);

    try {
      await appDatabase.updateTicket(
        widget.ticket.copyWith(tecnico: _tecnicoSeleccionado),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Técnico ${_tecnicoSeleccionado!.Nombre} asignado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
      widget.onAsignado(); // ✅ recarga la lista en tickets_page
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al asignar técnico: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Encabezado ──
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '#${widget.ticket.id}',
                    style: const TextStyle(
                      color: Color(0xFF5C6BC0),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _prioridadColor(widget.ticket.Prioridad).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.flag, size: 12,
                          color: _prioridadColor(widget.ticket.Prioridad)),
                      const SizedBox(width: 4),
                      Text(
                        widget.ticket.Prioridad,
                        style: TextStyle(
                          color: _prioridadColor(widget.ticket.Prioridad),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // ── Badge técnico actual ──
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.ticket.tecnico.id == 0
                        ? Colors.orange.withValues(alpha: 0.15)
                        : Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.ticket.tecnico.id == 0
                            ? Icons.person_off_outlined
                            : Icons.engineering,
                        size: 12,
                        color: widget.ticket.tecnico.id == 0
                            ? Colors.orange
                            : Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.ticket.tecnico.id == 0
                            ? 'Sin asignar'
                            : widget.ticket.tecnico.Nombre,
                        style: TextStyle(
                          color: widget.ticket.tecnico.id == 0
                              ? Colors.orange
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Info del ticket ──
            Row(
              children: [
                const Icon(Icons.computer, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Serial: ${widget.ticket.SerialEquipo}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.category_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Categoría: ${widget.ticket.categoria.Nombre}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Usuario: ${widget.ticket.usuario.Nombre.isNotEmpty ? widget.ticket.usuario.Nombre : 'Sin usuario'}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 20),

            // ── Lista desplegable de técnicos ──
            _cargandoTecnicos
                ? const Center(child: CircularProgressIndicator())
                : _tecnicos.isEmpty
                    ? const Text(
                        'No hay técnicos registrados',
                        style: TextStyle(color: Colors.grey),
                      )
                    : DropdownButtonFormField<models.Tecnico>(
                        initialValue: _tecnicoSeleccionado,
                        decoration: const InputDecoration(
                          labelText: 'Asignar técnico',
                          prefixIcon: Icon(Icons.engineering),
                          border: OutlineInputBorder(),
                        ),
                        items: _tecnicos
                            .map(
                              (t) => DropdownMenuItem(
                                value: t,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: const Color(0xFF5C6BC0),
                                      child: Text(
                                        t.Nombre.isNotEmpty
                                            ? t.Nombre[0].toUpperCase()
                                            : '?',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(t.Nombre),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (t) {
                          setState(() => _tecnicoSeleccionado = t);
                        },
                      ),
            const SizedBox(height: 12),

            // ── Botón asignar ──
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isLoading || _tecnicoSeleccionado == null
                    ? null
                    : _asignar,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.person_add),
                label: Text(
                  _isLoading ? 'Asignando...' : 'Asignar técnico',
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF5C6BC0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _prioridadColor(String prioridad) {
    switch (prioridad.toLowerCase()) {
      case 'alta': return Colors.red;
      case 'media': return Colors.orange;
      case 'baja': return Colors.green;
      default: return Colors.grey;
    }
  }
}