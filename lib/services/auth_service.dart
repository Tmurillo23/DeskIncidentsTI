import 'package:firebase_auth/firebase_auth.dart';

import 'app_logger.dart';

abstract class AuthService {
  Stream<User?> authStateChanges();

  User? get currentUser;

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logout();
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    AppLogger.info('Iniciando sesión con Firebase Auth');
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  @override
  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    AppLogger.info('Registrando usuario con Firebase Auth');
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    AppLogger.info('Cerrando sesión');
    await _firebaseAuth.signOut();
  }
}