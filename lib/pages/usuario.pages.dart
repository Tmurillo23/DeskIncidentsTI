import 'dart:async';

import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/desk.model.dart' as models;
import '../services/auth_service.dart';
import '../services/ticket_remote_service.dart';
import '../services/ticket_repository.dart';
import 'login.pages.dart';
import '../widgets/crear_ticket.dart';
import '../widgets/ticket_card.dart';

class UsuarioPage extends StatefulWidget {
  final models.Usuario usuario;

  const UsuarioPage({
    super.key,
    required this.usuario,
  });

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
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

  Future<void> _cargarTickets() async {
    setState(() => _isLoading = true);

    try {
      final todos = await _repository.getAllTickets();

      setState(() {
        _tickets = todos
            .where((t) => t.usuario.Correo == widget.usuario.Correo)
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _abrirCrearTicket() async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) => CrearTicketDialog(usuario: widget.usuario),
    );

    if (resultado == true) {
      await _cargarTickets();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket creado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: const Text(
          'Mis Tickets',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5C6BC0),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await _authService.logout();
              } catch (_) {}
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
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.confirmation_number_outlined,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No tienes tickets creados',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: _abrirCrearTicket,
                        icon: const Icon(Icons.add),
                        label: const Text('Crear mi primer ticket'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _cargarTickets,
                  child: ListView.builder(
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) {
                      return TicketCard(ticket: _tickets[index]);
                    },
                  ),
                ),
      floatingActionButton: _tickets.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _abrirCrearTicket,
              backgroundColor: const Color(0xFF5C6BC0),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Nuevo ticket',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}