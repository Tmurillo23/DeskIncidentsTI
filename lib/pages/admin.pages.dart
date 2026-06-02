import 'package:flutter/material.dart';

import '../widgets/admin_button.dart';
import '../widgets/agregar_tec.dart';
import '../services/auth_service.dart';
import 'login.pages.dart';
import 'tecnicos_page.dart';
import 'tickets_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: const Text(
          'Panel del Administrador',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
                await FirebaseAuthService().logout();
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.admin_panel_settings,
              size: 64,
              color: Color(0xFF5C6BC0),
            ),
            const SizedBox(height: 12),
            const Text(
              'Bienvenido, Administrador',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3949AB),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Selecciona la accion que desea realizar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: AdminButton(
                    icon: Icons.confirmation_number_outlined,
                    label: 'Ver todos los tickets',
                    color: const Color(0xFF5C6BC0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TicketsPage()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AdminButton(
                    icon: Icons.engineering,
                    label: 'Agregar un técnico nuevo',
                    color: const Color(0xFF7986CB),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const AgregarTecDialog(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AdminButton(
                    icon: Icons.people_outline,
                    label: 'Ver todos los técnicos',
                    color: const Color(0xFF9FA8DA),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TecnicosPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}