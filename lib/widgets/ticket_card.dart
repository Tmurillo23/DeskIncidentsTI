// lib/widgets/ticket_card.dart
import 'package:flutter/material.dart';
import '../models/desk.model.dart' as models;

class TicketCard extends StatelessWidget {
  final models.Ticket ticket;

  const TicketCard({
    super.key,
    required this.ticket,
  });

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

            // ── Encabezado: ID, Estado, Prioridad ──
            Row(
              children: [
                // Badge ID
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 9, 9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '#${ticket.id}',
                    style: const TextStyle(
                      color: Color(0xFF5C6BC0),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Badge Estado
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _estadoColor(ticket.Estado).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ticket.Estado,
                    style: TextStyle(
                      color: _estadoColor(ticket.Estado),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),

                // Badge Prioridad
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _prioridadColor(ticket.Prioridad).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.flag,
                        size: 12,
                        color: _prioridadColor(ticket.Prioridad),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ticket.Prioridad,
                        style: TextStyle(
                          color: _prioridadColor(ticket.Prioridad),
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

            // ── Serial del equipo ──
            Row(
              children: [
                const Icon(Icons.computer, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Serial: ${ticket.SerialEquipo}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),

            // ── Técnico y Usuario ──
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.engineering, size: 16, color: Color(0xFF5C6BC0)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Técnico',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            Text(
                              ticket.tecnico.Nombre.isNotEmpty
                                  ? ticket.tecnico.Nombre
                                  : 'Sin asignar',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline, size: 16, color: Color(0xFF5C6BC0)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Usuario',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            Text(
                              ticket.usuario.Nombre.isNotEmpty
                                  ? ticket.usuario.Nombre
                                  : 'Sin usuario',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Fecha y Categoría ──
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  _formatFecha(ticket.FechaCreacion),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                const Icon(Icons.category_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  ticket.categoria.Nombre.isNotEmpty
                      ? ticket.categoria.Nombre
                      : 'Sin categoría',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            // ── Comentario si tiene ──
            if (ticket.comentario.Contenido.isNotEmpty) ...[
              const Divider(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.comment_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      ticket.comentario.Contenido,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatFecha(DateTime fecha) {
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  Color _estadoColor(String estado) {
    switch (estado.toLowerCase()) {
      case 'abierto':
        return Colors.blue;
      case 'cerrado':
        return Colors.green;
      case 'pendiente':
        return Colors.orange;
      case 'en progreso':
        return Colors.purple;
      default:
        return Colors.grey;
    }
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