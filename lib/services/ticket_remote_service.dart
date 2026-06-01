import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/desk.model.dart' as models;
import 'app_logger.dart';

class RemoteCommentRecord {
  final models.Comentario comentario;
  final int ticketId;

  const RemoteCommentRecord({
    required this.comentario,
    required this.ticketId,
  });
}

class TicketRemoteService {
  final FirebaseFirestore _firestore;

  TicketRemoteService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _usersRef =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> get _categoriesRef =>
      _firestore.collection('categories');

  CollectionReference<Map<String, dynamic>> get _techniciansRef =>
      _firestore.collection('technicians');

  CollectionReference<Map<String, dynamic>> get _commentsRef =>
      _firestore.collection('comments');

  CollectionReference<Map<String, dynamic>> get _ticketsRef =>
      _firestore.collection('tickets');

  int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  String _docId(int id) => id.toString();

  Future<models.Usuario?> fetchUserByEmail(String email) async {
    final snapshot = await _usersRef
        .where('correo', isEqualTo: email.trim().toLowerCase())
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    final doc = snapshot.docs.first;
    return models.Usuario.fromFirestore(doc.data(), id: _asInt(doc.id));
  }

  Future<models.Usuario?> fetchUserById(int id) async {
    final doc = await _usersRef.doc(_docId(id)).get();
    if (!doc.exists || doc.data() == null) return null;
    return models.Usuario.fromFirestore(doc.data()!, id: id);
  }

  Future<List<models.Usuario>> fetchUsers() async {
    final snapshot = await _usersRef.get();
    return snapshot.docs
        .map(
          (doc) => models.Usuario.fromFirestore(
            doc.data(),
            id: _asInt(doc.id),
          ),
        )
        .toList();
  }

  Future<models.Usuario> upsertUser(models.Usuario usuario) async {
    AppLogger.debug('Firestore: upsert usuario ${usuario.id}');
    await _usersRef.doc(_docId(usuario.id)).set(
      {
        ...usuario.toFirestore(),
        'pendingSync': false,
      },
      SetOptions(merge: true),
    );
    return usuario.copyWith(pendingSync: false);
  }

  Future<void> deleteUser(int id) async {
    await _usersRef.doc(_docId(id)).delete();
  }

  Future<models.Categoria?> fetchCategoryById(int id) async {
    final doc = await _categoriesRef.doc(_docId(id)).get();
    if (!doc.exists || doc.data() == null) return null;
    return models.Categoria.fromFirestore(doc.data()!, id: id);
  }

  Future<List<models.Categoria>> fetchCategories() async {
    final snapshot = await _categoriesRef.get();
    return snapshot.docs
        .map(
          (doc) => models.Categoria.fromFirestore(
            doc.data(),
            id: _asInt(doc.id),
          ),
        )
        .toList();
  }

  Future<models.Categoria> upsertCategory(models.Categoria categoria) async {
    AppLogger.debug('Firestore: upsert categoría ${categoria.id}');
    await _categoriesRef.doc(_docId(categoria.id)).set(
      {
        ...categoria.toFirestore(),
        'pendingSync': false,
      },
      SetOptions(merge: true),
    );
    return categoria.copyWith(pendingSync: false);
  }

  Future<void> deleteCategory(int id) async {
    await _categoriesRef.doc(_docId(id)).delete();
  }

  Future<models.Tecnico?> fetchTechnicianById(int id) async {
    final doc = await _techniciansRef.doc(_docId(id)).get();
    if (!doc.exists || doc.data() == null) return null;
    return models.Tecnico.fromFirestore(doc.data()!, id: id);
  }

  Future<models.Tecnico?> fetchTechnicianByEmail(String email) async {
    final snapshot = await _techniciansRef
        .where('correo', isEqualTo: email.trim().toLowerCase())
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    final doc = snapshot.docs.first;
    return models.Tecnico.fromFirestore(doc.data(), id: _asInt(doc.id));
  }

  Future<List<models.Tecnico>> fetchTechnicians() async {
    final snapshot = await _techniciansRef.get();
    return snapshot.docs
        .map(
          (doc) => models.Tecnico.fromFirestore(
            doc.data(),
            id: _asInt(doc.id),
          ),
        )
        .toList();
  }

  Future<models.Tecnico> upsertTechnician(models.Tecnico tecnico) async {
    AppLogger.debug('Firestore: upsert técnico ${tecnico.id}');
    await _techniciansRef.doc(_docId(tecnico.id)).set(
      {
        ...tecnico.toFirestore(),
        'pendingSync': false,
      },
      SetOptions(merge: true),
    );
    return tecnico.copyWith(pendingSync: false);
  }

  Future<void> deleteTechnician(int id) async {
    await _techniciansRef.doc(_docId(id)).delete();
  }

  Future<models.Comentario?> fetchCommentById(int id) async {
    final doc = await _commentsRef.doc(_docId(id)).get();
    if (!doc.exists || doc.data() == null) return null;
    return models.Comentario.fromFirestore(doc.data()!, id: id);
  }

  Future<List<RemoteCommentRecord>> fetchComments() async {
    final snapshot = await _commentsRef.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      final comentario =
          models.Comentario.fromFirestore(data, id: _asInt(doc.id));
      final ticketId = _asInt(data['ticketId']);
      return RemoteCommentRecord(comentario: comentario, ticketId: ticketId);
    }).toList();
  }

  Future<models.Comentario> upsertComment(
    models.Comentario comentario, {
    required int ticketId,
  }) async {
    AppLogger.debug('Firestore: upsert comentario ${comentario.id}');
    final payload = {
      ...comentario.toFirestore(),
      'ticketId': ticketId,
      'pendingSync': false,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await _commentsRef.doc(_docId(comentario.id)).set(
      payload,
      SetOptions(merge: true),
    );

    await _ticketsRef
        .doc(_docId(ticketId))
        .collection('comments')
        .doc(_docId(comentario.id))
        .set(payload, SetOptions(merge: true));

    return comentario.copyWith(pendingSync: false);
  }

  Future<void> deleteComment(int id, {int? ticketId}) async {
    await _commentsRef.doc(_docId(id)).delete();

    if (ticketId != null) {
      await _ticketsRef
          .doc(_docId(ticketId))
          .collection('comments')
          .doc(_docId(id))
          .delete();
    }
  }

  Future<models.Ticket?> fetchTicketById(int id) async {
    final doc = await _ticketsRef.doc(_docId(id)).get();
    if (!doc.exists || doc.data() == null) return null;

    final ticket = models.Ticket.fromFirestore(doc.data()!, id: id);
    return _hydrateTicket(ticket);
  }

  Future<List<models.Ticket>> fetchTickets() async {
    AppLogger.debug('Firestore: consultando tickets');
    final snapshot = await _ticketsRef.get();

    final tickets = <models.Ticket>[];
    for (final doc in snapshot.docs) {
      final ticket = models.Ticket.fromFirestore(doc.data(), id: _asInt(doc.id));
      tickets.add(await _hydrateTicket(ticket));
    }
    return tickets;
  }

  Future<models.Ticket> upsertTicket(models.Ticket ticket) async {
    AppLogger.debug('Firestore: upsert ticket ${ticket.id}');

    if (ticket.usuario.id > 0) {
      await upsertUser(ticket.usuario);
    }
    if (ticket.categoria.id > 0) {
      await upsertCategory(ticket.categoria);
    }
    if (ticket.tecnico.id > 0) {
      await upsertTechnician(ticket.tecnico);
    }
    if (ticket.comentario.id > 0 ||
        ticket.comentario.Contenido.trim().isNotEmpty) {
      await upsertComment(ticket.comentario, ticketId: ticket.id);
    }

    await _ticketsRef.doc(_docId(ticket.id)).set(
      {
        ...ticket.toFirestore(),
        'pendingSync': false,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    return ticket.copyWith(pendingSync: false);
  }

  Future<void> deleteTicket(int id) async {
    await _ticketsRef.doc(_docId(id)).delete();
  }

  Future<models.Ticket> _hydrateTicket(models.Ticket ticket) async {
    final usuario = await fetchUserById(ticket.usuario.id);
    final categoria = await fetchCategoryById(ticket.categoria.id);
    final tecnico = await fetchTechnicianById(ticket.tecnico.id);
    final comentario = await fetchCommentById(ticket.comentario.id);

    models.Comentario finalComentario = ticket.comentario;

    if (comentario != null) {
      finalComentario = comentario;
    } else {
      final commentsSnapshot = await _ticketsRef
          .doc(_docId(ticket.id))
          .collection('comments')
          .orderBy('updatedAt', descending: true)
          .limit(1)
          .get();

      if (commentsSnapshot.docs.isNotEmpty) {
        final doc = commentsSnapshot.docs.first;
        finalComentario = models.Comentario.fromFirestore(
          doc.data(),
          id: _asInt(doc.id),
        );
      }
    }

    return ticket.copyWith(
      usuario: usuario ?? ticket.usuario,
      categoria: categoria ?? ticket.categoria,
      tecnico: tecnico ?? ticket.tecnico,
      comentario: finalComentario,
    );
  }
}