import 'package:desk_sla_app/data/app_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'pages/login.pages.dart';

/// Instancia global única de la base de datos local.
final AppDatabase appDatabase = AppDatabase();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DeskIncidentsApp());
}

class DeskIncidentsApp extends StatelessWidget {
  const DeskIncidentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeskIncidentsTI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5C6BC0),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}