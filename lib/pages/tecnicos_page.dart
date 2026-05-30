import 'package:flutter/material.dart';
import '../data/app_database.dart';
import '../models/desk.model.dart' as models;
import '../widgets/tecnico_card.dart';

class TecnicosPage extends StatefulWidget {
  const TecnicosPage({super.key});

  @override
  State<TecnicosPage> createState() => _TecnicosPageState();
}

class _TecnicosPageState extends State<TecnicosPage> {
  final AppDatabase _db = AppDatabase();
  List<models.Tecnico> _tecnicos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarTecnicos();
  }

  Future<void> _cargarTecnicos() async {
    setState(() => _isLoading = true);
    final tecnicos = await _db.getAllTecnicos();
    setState(() {
      _tecnicos = tecnicos;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: const Text(
          'Técnicos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5C6BC0),
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tecnicos.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No hay técnicos registrados',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _cargarTecnicos, // ✅ jalar para recargar
                  child: ListView.builder(
                    itemCount: _tecnicos.length,
                    itemBuilder: (context, index) {
                      return TecnicoCard(tecnico: _tecnicos[index]);
                    },
                  ),
                ),
    );
  }
}