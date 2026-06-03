import 'package:flutter/material.dart';
import '../models/desk.model.dart' as models;

class TecnicoCard extends StatelessWidget {
  final models.Tecnico tecnico;

  const TecnicoCard({
    super.key,
    required this.tecnico,
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

            // ── Encabezado: avatar y nombre ──
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF5C6BC0),
                  child: Text(
                    tecnico.Nombre.isNotEmpty
                        ? tecnico.Nombre[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tecnico.Nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3949AB),
                        ),
                      ),
                      Text(
                        tecnico.Correo,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Badge ID ──
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '#${tecnico.id}',
                    style: const TextStyle(
                      color: Color(0xFF5C6BC0),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // ── Documento ──
            Row(
              children: [
                const Icon(Icons.badge_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Doc: ${tecnico.DocumentoIdentidad}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ── Tickets asignados ──
            Row(
              children: [
                const Icon(Icons.confirmation_number_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Tickets asignados: ${tecnico.tickets?.length ?? 0}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),

            // ── Lista de tickets si tiene ──
            if (tecnico.tickets != null && tecnico.tickets!.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...tecnico.tickets!.map(
                (ticket) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE8EAF6)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Color(0xFF5C6BC0)),
                      const SizedBox(width: 8),
                      Text(
                        '#${ticket.id} — ${ticket.Estado}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      // ── Badge prioridad ──
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _prioridadColor(ticket.Prioridad).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          ticket.Prioridad,
                          style: TextStyle(
                            fontSize: 11,
                            color: _prioridadColor(ticket.Prioridad),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
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
}