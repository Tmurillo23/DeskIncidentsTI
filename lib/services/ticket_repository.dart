import '../data/app_database.dart';
import '../models/desk.model.dart' as models;
import 'app_logger.dart';
import 'auth_service.dart';
import 'ticket_remote_service.dart';
import 'ticket_rules_service.dart';

class TicketRepository {
  final AppDatabase db;
  final TicketRemoteService remoteService;
  final AuthService authService;
  final TicketRulesService rules;

  TicketRepository({
    required this.db,
    required this.remoteService,
    required this.authService,
    TicketRulesService? rules,
  }) : rules = rules ?? TicketRulesService();

  Stream<List<models.Ticket>> watchTickets() => db.watchTickets();

  Stream<List<models.Ticket>> watchTicketsFor(models.Usuario usuario) async* {
    yield* db.watchTickets().map(
          (tickets) => tickets.where((ticket) {
            return rules.canViewTicket(usuario, ticket);
          }).toList(),
        );
  }

  Future<List<models.Usuario>> getAllUsuarios() => db.getAllUsuarios();

  Future<List<models.Categoria>> getAllCategorias() => db.getAllCategorias();

  Future<List<models.Tecnico>> getAllTecnicos() => db.getAllTecnicos();

  Future<List<models.Comentario>> getAllComentarios() => db.getAllComentarios();

  Future<List<models.Ticket>> getAllTickets() => db.getAllTickets();

  Future<List<models.Usuario>> getPendingUsuarios() => db.getPendingUsuarios();

  Future<List<models.Categoria>> getPendingCategorias() =>
      db.getPendingCategorias();

  Future<List<models.Tecnico>> getPendingTecnicos() => db.getPendingTecnicos();

  Future<List<models.Comentario>> getPendingComentarios() =>
      db.getPendingComentarios();

  Future<List<models.Ticket>> getPendingTickets() => db.getPendingTickets();

  Future<models.Usuario> saveUsuario(models.Usuario usuario) async {
    final local = usuario.id == 0
        ? await db.insertUsuario(usuario.copyWith(pendingSync: true))
        : usuario.copyWith(pendingSync: true);

    if (usuario.id != 0) {
      await db.updateUsuario(local);
    }

    try {
      final remote = await remoteService.upsertUser(local);
      await db.markUsuarioAsSynced(remote.id);
      return remote.copyWith(pendingSync: false);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Usuario guardado localmente y pendiente de sincronización: ${local.id}',
      );
      AppLogger.error(
        'Error sincronizando usuario',
        error: error,
        stackTrace: stackTrace,
      );
      return local;
    }
  }

  Future<void> deleteUsuario(int id) async {
    await db.deleteUsuario(id);
    try {
      await remoteService.deleteUser(id);
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error eliminando usuario remoto',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<models.Categoria> saveCategoria(models.Categoria categoria) async {
    final local = categoria.id == 0
        ? await db.insertCategoria(categoria.copyWith(pendingSync: true))
        : categoria.copyWith(pendingSync: true);

    if (categoria.id != 0) {
      await db.updateCategoria(local);
    }

    try {
      final remote = await remoteService.upsertCategory(local);
      await db.markCategoriaAsSynced(remote.id);
      return remote.copyWith(pendingSync: false);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Categoría guardada localmente y pendiente de sincronización: ${local.id}',
      );
      AppLogger.error(
        'Error sincronizando categoría',
        error: error,
        stackTrace: stackTrace,
      );
      return local;
    }
  }

  Future<void> deleteCategoria(int id) async {
    await db.deleteCategoria(id);
    try {
      await remoteService.deleteCategory(id);
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error eliminando categoría remota',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<models.Tecnico> saveTecnico(models.Tecnico tecnico) async {
    final local = tecnico.id == 0
        ? await db.insertTecnico(tecnico.copyWith(pendingSync: true))
        : tecnico.copyWith(pendingSync: true);

    if (tecnico.id != 0) {
      await db.updateTecnico(local);
    }

    try {
      final remote = await remoteService.upsertTechnician(local);
      await db.markTecnicoAsSynced(remote.id);
      return remote.copyWith(pendingSync: false);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Técnico guardado localmente y pendiente de sincronización: ${local.id}',
      );
      AppLogger.error(
        'Error sincronizando técnico',
        error: error,
        stackTrace: stackTrace,
      );
      return local;
    }
  }

  Future<void> deleteTecnico(int id) async {
    await db.deleteTecnico(id);
    try {
      await remoteService.deleteTechnician(id);
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error eliminando técnico remoto',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<models.Comentario> saveComentario(
    models.Comentario comentario, {
    required int ticketId,
  }) async {
    final local = comentario.id == 0
        ? await db.insertComentario(
            comentario.copyWith(pendingSync: true),
            ticketId: ticketId,
          )
        : comentario.copyWith(pendingSync: true);

    if (comentario.id != 0) {
      await db.updateComentario(local, ticketId: ticketId);
    }

    try {
      final remote = await remoteService.upsertComment(
        local,
        ticketId: ticketId,
      );
      await db.markComentarioAsSynced(remote.id);
      return remote.copyWith(pendingSync: false);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Comentario guardado localmente y pendiente de sincronización: ${local.id}',
      );
      AppLogger.error(
        'Error sincronizando comentario',
        error: error,
        stackTrace: stackTrace,
      );
      return local;
    }
  }

  Future<void> deleteComentario(int id) async {
    await db.deleteComentario(id);
    try {
      await remoteService.deleteComment(id);
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error eliminando comentario remoto',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<models.Ticket> saveTicket(models.Ticket ticket) async {
    final normalizedPriority = rules.determineInitialPriority(ticket.categoria);
    final normalizedStatus =
        ticket.Estado.trim().isEmpty ? 'Pendiente' : ticket.Estado.trim();

    var localTicket = ticket.copyWith(
      Estado: normalizedStatus,
      Prioridad: normalizedPriority,
      pendingSync: true,
    );

    if (localTicket.id == 0) {
      localTicket = await db.insertTicket(localTicket);
    } else {
      await db.updateTicket(localTicket);
    }

    if (localTicket.comentario.Contenido.trim().isNotEmpty ||
        localTicket.comentario.id != 0) {
      final savedComment = await saveComentario(
        localTicket.comentario,
        ticketId: localTicket.id,
      );
      localTicket = localTicket.copyWith(comentario: savedComment);
    }

    try {
      final remote = await remoteService.upsertTicket(localTicket);
      await db.markTicketAsSynced(remote.id);

      if (localTicket.comentario.id > 0) {
        await db.markComentarioAsSynced(localTicket.comentario.id);
      }

      return remote.copyWith(
        comentario: localTicket.comentario.copyWith(pendingSync: false),
        pendingSync: false,
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Ticket guardado localmente y pendiente de sincronización: ${localTicket.id}',
      );
      AppLogger.error(
        'Error sincronizando ticket',
        error: error,
        stackTrace: stackTrace,
      );
      return localTicket;
    }
  }

  Future<models.Ticket> createTicket({
    required models.Usuario usuario,
    required models.Categoria categoria,
    required models.Tecnico tecnico,
    required String serialEquipo,
    String comentarioInicial = '',
  }) async {
    if (!rules.canCreateTicket(usuario)) {
      throw StateError('El usuario no tiene permiso para crear tickets.');
    }

    final ticket = models.Ticket(
      id: 0,
      Estado: 'Pendiente',
      FechaCreacion: DateTime.now(),
      Prioridad: rules.determineInitialPriority(categoria),
      SerialEquipo: serialEquipo.trim(),
      pendingSync: true,
      tecnico: tecnico,
      categoria: categoria,
      usuario: usuario,
      comentario: models.Comentario(
        id: 0,
        Contenido: comentarioInicial.trim(),
        pendingSync: true,
      ),
    );

    return saveTicket(ticket);
  }

  Future<models.Ticket> assignTicket({
    required models.Usuario actor,
    required models.Ticket ticket,
    required models.Tecnico tecnico,
  }) async {
    if (!rules.canReassignTicket(actor)) {
      throw StateError('Solo el administrador puede reasignar tickets.');
    }

    if (ticket.Estado.trim().toLowerCase() == 'cerrado') {
      throw StateError('Un ticket cerrado no puede reasignarse.');
    }

    return saveTicket(
      ticket.copyWith(
        tecnico: tecnico,
        Estado: 'Asignado',
      ),
    );
  }

  Future<models.Ticket> changeTicketStatus({
    required models.Usuario actor,
    required models.Ticket ticket,
    required String nextStatus,
    String? solutionComment,
  }) async {
    final current = ticket.Estado.trim();
    final next = nextStatus.trim();

    if (!rules.canTransition(current, next)) {
      throw StateError('Transición inválida: $current → $next');
    }

    if (next.toLowerCase() == 'resuelto' &&
        !rules.canResolveTicket(actor, ticket)) {
      throw StateError('No tienes permiso para resolver este ticket.');
    }

    if (next.toLowerCase() == 'cerrado') {
      if (!rules.canCloseTicket(
        actor,
        ticket,
        solutionComment: solutionComment,
      )) {
        throw StateError(
          'Un ticket cerrado requiere permiso y comentario de solución.',
        );
      }
    }

    final updatedComment = (solutionComment ?? '').trim().isEmpty
        ? ticket.comentario
        : ticket.comentario.copyWith(
            Contenido: solutionComment!.trim(),
            pendingSync: true,
          );

    final updatedTicket = ticket.copyWith(
      Estado: next,
      comentario: updatedComment,
    );

    return saveTicket(updatedTicket);
  }

  Future<void> refreshOverdueTickets() async {
    final tickets = await db.getAllTickets();
    for (final ticket in tickets) {
      if (rules.isTicketOverdue(ticket)) {
        await saveTicket(ticket.copyWith(Estado: 'Vencido'));
      }
    }
  }

  Future<void> pullRemoteToLocal() async {
    AppLogger.info('Sincronizando datos remotos hacia la base local');

    final usuarios = await remoteService.fetchUsers();
    for (final usuario in usuarios) {
      await db.upsertUsuarioFromRemote(usuario);
    }

    final categorias = await remoteService.fetchCategories();
    for (final categoria in categorias) {
      await db.upsertCategoriaFromRemote(categoria);
    }

    final tecnicos = await remoteService.fetchTechnicians();
    for (final tecnico in tecnicos) {
      await db.upsertTecnicoFromRemote(tecnico);
    }

    final tickets = await remoteService.fetchTickets();
    for (final ticket in tickets) {
      await db.upsertTicketFromRemote(ticket);
    }

    final comments = await remoteService.fetchComments();
    for (final remoteComment in comments) {
      await db.upsertComentarioFromRemote(
        remoteComment.comentario,
        ticketId: remoteComment.ticketId,
      );
    }
  }

  Future<void> pushPendingLocalToRemote() async {
    AppLogger.info('Sincronizando pendientes locales hacia Firestore');

    final pendingUsuarios = await db.getPendingUsuarios();
    for (final usuario in pendingUsuarios) {
      try {
        await remoteService.upsertUser(usuario);
        await db.markUsuarioAsSynced(usuario.id);
      } catch (error, stackTrace) {
        AppLogger.error(
          'Error sincronizando usuario pendiente ${usuario.id}',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    final pendingCategorias = await db.getPendingCategorias();
    for (final categoria in pendingCategorias) {
      try {
        await remoteService.upsertCategory(categoria);
        await db.markCategoriaAsSynced(categoria.id);
      } catch (error, stackTrace) {
        AppLogger.error(
          'Error sincronizando categoría pendiente ${categoria.id}',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    final pendingTecnicos = await db.getPendingTecnicos();
    for (final tecnico in pendingTecnicos) {
      try {
        await remoteService.upsertTechnician(tecnico);
        await db.markTecnicoAsSynced(tecnico.id);
      } catch (error, stackTrace) {
        AppLogger.error(
          'Error sincronizando técnico pendiente ${tecnico.id}',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    final pendingCommentRows =
        await (db.select(db.comentarioModel)..where((c) => c.pendingSync.equals(true)))
            .get();

    for (final row in pendingCommentRows) {
      final comentario = models.Comentario(
        id: row.id,
        Contenido: row.contenido,
        pendingSync: row.pendingSync,
      );

      try {
        await remoteService.upsertComment(
          comentario,
          ticketId: row.ticketId,
        );
        await db.markComentarioAsSynced(row.id);
      } catch (error, stackTrace) {
        AppLogger.error(
          'Error sincronizando comentario pendiente ${row.id}',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    final pendingTickets = await db.getPendingTickets();
    for (final ticket in pendingTickets) {
      try {
        await remoteService.upsertTicket(ticket);
        await db.markTicketAsSynced(ticket.id);
      } catch (error, stackTrace) {
        AppLogger.error(
          'Error sincronizando ticket pendiente ${ticket.id}',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  Future<void> syncAll() async {
    await pushPendingLocalToRemote();
    await pullRemoteToLocal();
    await refreshOverdueTickets();
  }

  Future<models.Usuario?> findUserByEmail(String email) async {
    final remote = await remoteService.fetchUserByEmail(email);
    if (remote != null) {
      await db.upsertUsuarioFromRemote(remote);
      return remote;
    }

    final users = await db.getAllUsuarios();
    for (final user in users) {
      if (user.Correo.trim().toLowerCase() == email.trim().toLowerCase()) {
        return user;
      }
    }

    return null;
  }

  Future<models.Tecnico?> findTechnicianByEmail(String email) async {
    final remote = await remoteService.fetchTechnicianByEmail(email);
    if (remote != null) {
      await db.upsertTecnicoFromRemote(remote);
      return remote;
    }

    final technicians = await db.getAllTecnicos();
    for (final tech in technicians) {
      if (tech.Correo.trim().toLowerCase() == email.trim().toLowerCase()) {
        return tech;
      }
    }

    return null;
  }

  Future<models.Usuario?> getLoggedUserProfile() async {
    final currentUser = authService.currentUser;
    if (currentUser == null) return null;

    final email = currentUser.email;
    if (email == null || email.trim().isEmpty) return null;

    return findUserByEmail(email);
  }
}