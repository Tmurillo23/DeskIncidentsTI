import 'package:flutter/material.dart';
import '../main.dart';
import '../models/desk.model.dart' as models;
import '../widgets/asignar_tec_card.dart'; // ✅ usa AsignarTecCard

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  List<models.Ticket> _tickets = [];
  bool _isLoading = true;
  String _filtroEstado = 'Todos';

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    setState(() => _isLoading = true);
    try {
      final tickets = await appDatabase.getAllTickets();
      setState(() {
        _tickets = tickets;
        _isLoading = false;
      });
    } catch (e) {
      print('ERROR: $e');
      setState(() => _isLoading = false);
    }
  }

  List<models.Ticket> get _ticketsFiltrados {
    if (_filtroEstado == 'Todos') return _tickets;
    return _tickets.where((t) => t.Estado == _filtroEstado).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: const Text(
          'Tickets',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5C6BC0),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [

          // ── Filtros por estado ──
          Container(
            color: const Color(0xFF5C6BC0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: ['Todos', 'Abierto', 'En progreso', 'Pendiente', 'Cerrado']
                    .map(
                      (estado) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(estado),
                          selected: _filtroEstado == estado,
                          onSelected: (_) {
                            setState(() => _filtroEstado = estado);
                          },
                          selectedColor: Colors.white,
                          labelStyle: TextStyle(
                            color: _filtroEstado == estado
                                ? const Color(0xFF5C6BC0)
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          checkmarkColor: const Color(0xFF5C6BC0),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          // ── Contador ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Text(
                  '${_ticketsFiltrados.length} ticket${_ticketsFiltrados.length != 1 ? 's' : ''}',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          // ── Lista ──
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _ticketsFiltrados.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.confirmation_number_outlined,
                                size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'No hay tickets',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _cargarDatos,
                        child: ListView.builder(
                          itemCount: _ticketsFiltrados.length,
                          itemBuilder: (context, index) {
                            final ticket = _ticketsFiltrados[index];
                            // ✅ usa AsignarTecCard
                            return AsignarTecCard(
                              ticket: ticket,
                              onAsignado: _cargarDatos,
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}