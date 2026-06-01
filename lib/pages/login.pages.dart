import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/desk.model.dart' as models;
import '../services/auth_service.dart';
import '../services/ticket_remote_service.dart';
import '../services/ticket_repository.dart';
import 'admin.pages.dart';
import 'tecnico.pages.dart';
import 'usuario.pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AppDatabase _db = AppDatabase();
  final _authService = FirebaseAuthService();
  final _remoteService = TicketRemoteService();
  late final TicketRepository _repository = TicketRepository(
    db: _db,
    remoteService: _remoteService,
    authService: _authService,
  );

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nombreController = TextEditingController();
  final _documentoController = TextEditingController();

  bool _isLoading = false;
  bool _isRegisterMode = false;
  String? _errorMessage;
  String _rolSeleccionado = 'usuario';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nombreController.dispose();
    _documentoController.dispose();
    unawaited(_db.close());
    super.dispose();
  }

  String _normalizeRole(String role) {
    final normalized = role.trim().toLowerCase();
    if (normalized == 'usuario') return 'solicitante';
    if (normalized == 'admin') return 'administrador';
    return normalized;
  }

  models.Usuario _buildUsuarioProfile({
    required String email,
    required String nombre,
    required int documento,
    required String role,
  }) {
    return models.Usuario(
      id: 0,
      Nombre: nombre,
      DocumentoIdentidad: documento,
      Correo: email.trim().toLowerCase(),
      Rol: _normalizeRole(role),
      pendingSync: true,
    );
  }

  models.Tecnico _buildTecnicoProfile({
    required String email,
    required String nombre,
    required int documento,
    required String password,
  }) {
    return models.Tecnico(
      id: 0,
      Nombre: nombre,
      DocumentoIdentidad: documento,
      Correo: email.trim().toLowerCase(),
      Password: password,
      pendingSync: true,
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      if (_isRegisterMode) {
        await _authService.registerWithEmailAndPassword(
          email: email,
          password: password,
        );

        final nombre = _nombreController.text.trim();
        final documento = int.tryParse(_documentoController.text.trim()) ?? 0;

        if (_rolSeleccionado == 'tecnico') {
          await _repository.saveTecnico(
            _buildTecnicoProfile(
              email: email,
              nombre: nombre,
              documento: documento,
              password: password,
            ),
          );
        } else {
          await _repository.saveUsuario(
            _buildUsuarioProfile(
              email: email,
              nombre: nombre,
              documento: documento,
              role: _rolSeleccionado,
            ),
          );
        }

        await _authService.logout();

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cuenta creada correctamente. Ahora inicia sesión.'),
            backgroundColor: Colors.green,
          ),
        );

        setState(() {
          _isRegisterMode = false;
          _nombreController.clear();
          _documentoController.clear();
          _emailController.clear();
          _passwordController.clear();
          _rolSeleccionado = 'usuario';
        });
      } else {
        await _authService.loginWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (_rolSeleccionado == 'tecnico') {
          var tecnico = await _repository.findTechnicianByEmail(email);

          if (tecnico == null) {
            throw Exception('No existe un perfil de técnico asociado a este correo');
          }

          tecnico = tecnico.copyWith(
            Correo: email,
          );

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => TecnicoPage(tecnico: tecnico!),
            ),
          );
          return;
        }

        models.Usuario? usuarioLogueado = await _repository.findUserByEmail(email);

        usuarioLogueado ??= await _repository.saveUsuario(
            _buildUsuarioProfile(
              email: email,
              nombre: email.split('@').first,
              documento: 0,
              role: _rolSeleccionado,
            ),
          );

        final rolReal = _normalizeRole(usuarioLogueado.Rol);

        if (!mounted) return;

        switch (rolReal) {
          case 'administrador':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminPage()),
            );
            break;
          case 'solicitante':
          default:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => UsuarioPage(usuario: usuarioLogueado!),
              ),
            );
            break;
        }
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        _errorMessage = _mapFirebaseAuthError(error);
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'El correo no tiene un formato válido';
      case 'user-disabled':
        return 'Este usuario está deshabilitado';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Las credenciales no coinciden';
      case 'email-already-in-use':
        return 'Ya existe una cuenta con este correo';
      case 'weak-password':
        return 'La contraseña es demasiado débil';
      case 'network-request-failed':
        return 'Revisa tu conexión a internet';
      default:
        return 'No fue posible completar la autenticación';
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu correo';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'El correo no tiene un formato válido';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu contraseña';
    if (value.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
    return null;
  }

  String? _validateNombre(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu nombre';
    return null;
  }

  String? _validateDocumento(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu documento';
    if (int.tryParse(value) == null) return 'El documento debe ser numérico';
    return null;
  }

  Widget _buildLoginButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Iniciar sesión como:',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _rolSeleccionado = 'admin';
                          _isRegisterMode = false;
                          _errorMessage = null;
                        });
                      },
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text('Admin'),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      _rolSeleccionado == 'admin' && !_isRegisterMode
                          ? const Color.fromARGB(255, 41, 132, 224)
                          : null,
                  side: BorderSide(
                    color: _rolSeleccionado == 'admin' && !_isRegisterMode
                        ? const Color.fromARGB(255, 41, 132, 224)
                        : Colors.grey,
                    width: _rolSeleccionado == 'admin' && !_isRegisterMode ? 2 : 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _rolSeleccionado = 'tecnico';
                          _isRegisterMode = false;
                          _errorMessage = null;
                        });
                      },
                icon: const Icon(Icons.engineering),
                label: const Text('Técnico'),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      _rolSeleccionado == 'tecnico' && !_isRegisterMode
                          ? const Color.fromARGB(255, 41, 132, 224)
                          : null,
                  side: BorderSide(
                    color: _rolSeleccionado == 'tecnico' && !_isRegisterMode
                        ? const Color.fromARGB(255, 41, 132, 224)
                        : Colors.grey,
                    width: _rolSeleccionado == 'tecnico' && !_isRegisterMode ? 2 : 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _rolSeleccionado = 'usuario';
                          _isRegisterMode = false;
                          _errorMessage = null;
                        });
                      },
                icon: const Icon(Icons.person),
                label: const Text('Usuario'),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      _rolSeleccionado == 'usuario' && !_isRegisterMode
                          ? const Color.fromARGB(255, 41, 132, 224)
                          : null,
                  side: BorderSide(
                    color: _rolSeleccionado == 'usuario' && !_isRegisterMode
                        ? const Color.fromARGB(255, 58, 108, 208)
                        : Colors.grey,
                    width: _rolSeleccionado == 'usuario' && !_isRegisterMode ? 2 : 1,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _isLoading
              ? null
              : () {
                  setState(() {
                    _isRegisterMode = true;
                    _errorMessage = null;
                  });
                },
          icon: const Icon(Icons.person_add),
          label: const Text('Registrarse'),
          style: OutlinedButton.styleFrom(
            foregroundColor: _isRegisterMode
                ? const Color.fromARGB(255, 41, 132, 224)
                : null,
            side: BorderSide(
              color: _isRegisterMode
                  ? const Color.fromARGB(255, 41, 132, 224)
                  : Colors.grey,
              width: _isRegisterMode ? 2 : 1,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.task_alt,
                          size: 56,
                          color: Color.fromARGB(255, 81, 142, 222),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'DeskApp',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 24),
                        _buildLoginButtons(),
                        const SizedBox(height: 24),
                        if (_isRegisterMode) ...[
                          TextFormField(
                            controller: _nombreController,
                            validator: _validateNombre,
                            decoration: const InputDecoration(
                              labelText: 'Nombre completo',
                              prefixIcon: Icon(Icons.badge_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _documentoController,
                            keyboardType: TextInputType.number,
                            validator: _validateDocumento,
                            decoration: const InputDecoration(
                              labelText: 'Documento de identidad',
                              prefixIcon: Icon(Icons.numbers),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          decoration: const InputDecoration(
                            labelText: 'Correo',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: _validatePassword,
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red.shade800),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: _isLoading ? null : _submit,
                          icon: _isLoading
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(_isRegisterMode
                                  ? Icons.person_add
                                  : Icons.login),
                          label: Text(
                            _isLoading
                                ? 'Procesando...'
                                : _isRegisterMode
                                    ? 'Crear cuenta'
                                    : 'Ingresar como $_rolSeleccionado',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}