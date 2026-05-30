import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../models/desk.model.dart' as models;

part 'app_database.g.dart';

class UsuarioModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  IntColumn get documentoIdentidad => integer()();
  TextColumn get correo => text()();
  TextColumn get rol => text()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();
}

class CategoriaModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get descripcion => text()();
  TextColumn get tiempoRespuesta => text()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();
}

class TecnicoModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  IntColumn get documentoIdentidad => integer()();
  TextColumn get correo => text()();
  TextColumn get password => text()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();
}

class ComentarioModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contenido => text()();
  IntColumn get ticketId => integer().references(TicketModel, #id)();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();
}

class TicketModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get estado => text()();
  DateTimeColumn get fechaCreacion => dateTime()();
  TextColumn get prioridad => text()();
  TextColumn get serialEquipo => text()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();
  IntColumn get tecnicoId => integer().references(TecnicoModel, #id)();
  IntColumn get categoriaId => integer().references(CategoriaModel, #id)();
  IntColumn get usuarioId => integer().references(UsuarioModel, #id)();
}

@DriftDatabase(
  tables: [
    UsuarioModel,
    CategoriaModel,
    TecnicoModel,
    ComentarioModel,
    TicketModel,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'tickets_app_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }

  models.Usuario _mapUsuario(UsuarioModelData row) => models.Usuario(
        id: row.id,
        Nombre: row.nombre,
        DocumentoIdentidad: row.documentoIdentidad,
        Correo: row.correo,
        Rol: row.rol,
        pendingSync: row.pendingSync,
      );

  models.Categoria _mapCategoria(CategoriaModelData row) => models.Categoria(
        id: row.id,
        Nombre: row.nombre,
        Descripcion: row.descripcion,
        TiempoRespuesta: row.tiempoRespuesta,
        pendingSync: row.pendingSync,
      );

  models.Tecnico _mapTecnico(TecnicoModelData row) => models.Tecnico(
        id: row.id,
        Nombre: row.nombre,
        DocumentoIdentidad: row.documentoIdentidad,
        Correo: row.correo,
        Password: row.password,
        pendingSync: row.pendingSync,
      );

  models.Comentario _mapComentario(ComentarioModelData row) =>
      models.Comentario(
        id: row.id,
        Contenido: row.contenido,
        pendingSync: row.pendingSync,
      );

  Future<models.Ticket> _mapTicket(TicketModelData row) async {
    final tecnicoRow = await (select(tecnicoModel)
          ..where((t) => t.id.equals(row.tecnicoId)))
        .getSingleOrNull();
    final categoriaRow = await (select(categoriaModel)
          ..where((c) => c.id.equals(row.categoriaId)))
        .getSingleOrNull();
    final usuarioRow = await (select(usuarioModel)
          ..where((u) => u.id.equals(row.usuarioId)))
        .getSingleOrNull();
    final comentarioRow = await (select(comentarioModel)
          ..where((c) => c.ticketId.equals(row.id)))
        .getSingleOrNull();

    return models.Ticket(
      id: row.id,
      Estado: row.estado,
      FechaCreacion: row.fechaCreacion,
      Prioridad: row.prioridad,
      SerialEquipo: row.serialEquipo,
      pendingSync: row.pendingSync,
      tecnico: tecnicoRow != null
          ? _mapTecnico(tecnicoRow)
          : models.Tecnico(
              id: 0,
              Nombre: 'Pendiente',
              DocumentoIdentidad: 0,
              Correo: '',
              Password: '',
              pendingSync: false,
            ),
      categoria: categoriaRow != null
          ? _mapCategoria(categoriaRow)
          : models.Categoria(
              id: 0,
              Nombre: '',
              Descripcion: '',
              TiempoRespuesta: '',
              pendingSync: false,
            ),
      usuario: usuarioRow != null
          ? _mapUsuario(usuarioRow)
          : models.Usuario(
              id: 0,
              Nombre: '',
              DocumentoIdentidad: 0,
              Correo: '',
              Rol: '',
              pendingSync: false,
            ),
      comentario: comentarioRow != null
          ? _mapComentario(comentarioRow)
          : models.Comentario(
              id: 0,
              Contenido: '',
              pendingSync: false,
            ),
    );
  }

  Future<List<models.Usuario>> getAllUsuarios() async {
    final rows = await select(usuarioModel).get();
    return rows.map(_mapUsuario).toList();
  }

  Future<models.Usuario> insertUsuario(models.Usuario usuario) async {
    final insertedId = await into(usuarioModel).insert(
      UsuarioModelCompanion.insert(
        nombre: usuario.Nombre,
        documentoIdentidad: usuario.DocumentoIdentidad,
        correo: usuario.Correo,
        rol: usuario.Rol,
        pendingSync: Value(usuario.pendingSync),
      ),
    );
    return usuario.copyWith(id: insertedId);
  }

  Future<void> updateUsuario(models.Usuario usuario) async {
    await update(usuarioModel).replace(
      UsuarioModelData(
        id: usuario.id,
        nombre: usuario.Nombre,
        documentoIdentidad: usuario.DocumentoIdentidad,
        correo: usuario.Correo,
        rol: usuario.Rol,
        pendingSync: usuario.pendingSync,
      ),
    );
  }

  Future<void> deleteUsuario(int id) async {
    await (delete(usuarioModel)..where((u) => u.id.equals(id))).go();
  }

  Future<List<models.Usuario>> getPendingUsuarios() async {
    final rows = await (select(usuarioModel)
          ..where((u) => u.pendingSync.equals(true)))
        .get();
    return rows.map(_mapUsuario).toList();
  }

  Future<void> markUsuarioAsSynced(int id) async {
    await (update(usuarioModel)..where((u) => u.id.equals(id))).write(
      const UsuarioModelCompanion(pendingSync: Value(false)),
    );
  }

  Future<void> upsertUsuarioFromRemote(models.Usuario usuario) async {
    await into(usuarioModel).insertOnConflictUpdate(
      UsuarioModelCompanion(
        id: Value(usuario.id),
        nombre: Value(usuario.Nombre),
        documentoIdentidad: Value(usuario.DocumentoIdentidad),
        correo: Value(usuario.Correo),
        rol: Value(usuario.Rol),
        pendingSync: const Value(false),
      ),
    );
  }

  Future<List<models.Categoria>> getAllCategorias() async {
    final rows = await select(categoriaModel).get();
    return rows.map(_mapCategoria).toList();
  }

  Future<models.Categoria> insertCategoria(models.Categoria categoria) async {
    final insertedId = await into(categoriaModel).insert(
      CategoriaModelCompanion.insert(
        nombre: categoria.Nombre,
        descripcion: categoria.Descripcion,
        tiempoRespuesta: categoria.TiempoRespuesta,
        pendingSync: Value(categoria.pendingSync),
      ),
    );
    return categoria.copyWith(id: insertedId);
  }

  Future<void> updateCategoria(models.Categoria categoria) async {
    await update(categoriaModel).replace(
      CategoriaModelData(
        id: categoria.id,
        nombre: categoria.Nombre,
        descripcion: categoria.Descripcion,
        tiempoRespuesta: categoria.TiempoRespuesta,
        pendingSync: categoria.pendingSync,
      ),
    );
  }

  Future<void> deleteCategoria(int id) async {
    await (delete(categoriaModel)..where((c) => c.id.equals(id))).go();
  }

  Future<List<models.Categoria>> getPendingCategorias() async {
    final rows = await (select(categoriaModel)
          ..where((c) => c.pendingSync.equals(true)))
        .get();
    return rows.map(_mapCategoria).toList();
  }

  Future<void> markCategoriaAsSynced(int id) async {
    await (update(categoriaModel)..where((c) => c.id.equals(id))).write(
      const CategoriaModelCompanion(pendingSync: Value(false)),
    );
  }

  Future<void> upsertCategoriaFromRemote(models.Categoria categoria) async {
    await into(categoriaModel).insertOnConflictUpdate(
      CategoriaModelCompanion(
        id: Value(categoria.id),
        nombre: Value(categoria.Nombre),
        descripcion: Value(categoria.Descripcion),
        tiempoRespuesta: Value(categoria.TiempoRespuesta),
        pendingSync: const Value(false),
      ),
    );
  }

  Future<List<models.Tecnico>> getAllTecnicos() async {
    final rows = await select(tecnicoModel).get();
    return rows.map(_mapTecnico).toList();
  }

  Future<models.Tecnico> insertTecnico(models.Tecnico tecnico) async {
    final insertedId = await into(tecnicoModel).insert(
      TecnicoModelCompanion.insert(
        nombre: tecnico.Nombre,
        documentoIdentidad: tecnico.DocumentoIdentidad,
        correo: tecnico.Correo,
        password: tecnico.Password,
        pendingSync: Value(tecnico.pendingSync),
      ),
    );
    return tecnico.copyWith(id: insertedId);
  }

  Future<void> updateTecnico(models.Tecnico tecnico) async {
    await update(tecnicoModel).replace(
      TecnicoModelData(
        id: tecnico.id,
        nombre: tecnico.Nombre,
        documentoIdentidad: tecnico.DocumentoIdentidad,
        correo: tecnico.Correo,
        password: tecnico.Password,
        pendingSync: tecnico.pendingSync,
      ),
    );
  }

  Future<void> deleteTecnico(int id) async {
    await (delete(tecnicoModel)..where((t) => t.id.equals(id))).go();
  }

  Future<List<models.Tecnico>> getPendingTecnicos() async {
    final rows = await (select(tecnicoModel)
          ..where((t) => t.pendingSync.equals(true)))
        .get();
    return rows.map(_mapTecnico).toList();
  }

  Future<void> markTecnicoAsSynced(int id) async {
    await (update(tecnicoModel)..where((t) => t.id.equals(id))).write(
      const TecnicoModelCompanion(pendingSync: Value(false)),
    );
  }

  Future<void> upsertTecnicoFromRemote(models.Tecnico tecnico) async {
    await into(tecnicoModel).insertOnConflictUpdate(
      TecnicoModelCompanion(
        id: Value(tecnico.id),
        nombre: Value(tecnico.Nombre),
        documentoIdentidad: Value(tecnico.DocumentoIdentidad),
        correo: Value(tecnico.Correo),
        password: Value(tecnico.Password),
        pendingSync: const Value(false),
      ),
    );
  }

  Future<models.Tecnico> getTecnicoConTickets(int id) async {
    final tecnicoRow =
        await (select(tecnicoModel)..where((t) => t.id.equals(id))).getSingle();
    final ticketsList = await getTicketsByTecnico(id);

    return models.Tecnico(
      id: tecnicoRow.id,
      Nombre: tecnicoRow.nombre,
      DocumentoIdentidad: tecnicoRow.documentoIdentidad,
      Correo: tecnicoRow.correo,
      Password: tecnicoRow.password,
      pendingSync: tecnicoRow.pendingSync,
      tickets: ticketsList,
    );
  }

  Future<List<models.Comentario>> getAllComentarios() async {
    final rows = await select(comentarioModel).get();
    return rows.map(_mapComentario).toList();
  }

  Future<models.Comentario> insertComentario(
    models.Comentario comentario, {
    required int ticketId,
  }) async {
    final insertedId = await into(comentarioModel).insert(
      ComentarioModelCompanion.insert(
        contenido: comentario.Contenido,
        ticketId: ticketId,
        pendingSync: Value(comentario.pendingSync),
      ),
    );
    return comentario.copyWith(id: insertedId);
  }

  Future<void> updateComentario(
    models.Comentario comentario, {
    required int ticketId,
  }) async {
    await update(comentarioModel).replace(
      ComentarioModelData(
        id: comentario.id,
        contenido: comentario.Contenido,
        ticketId: ticketId,
        pendingSync: comentario.pendingSync,
      ),
    );
  }

  Future<void> deleteComentario(int id) async {
    await (delete(comentarioModel)..where((c) => c.id.equals(id))).go();
  }

  Future<List<models.Comentario>> getPendingComentarios() async {
    final rows = await (select(comentarioModel)
          ..where((c) => c.pendingSync.equals(true)))
        .get();
    return rows.map(_mapComentario).toList();
  }

  Future<void> markComentarioAsSynced(int id) async {
    await (update(comentarioModel)..where((c) => c.id.equals(id))).write(
      const ComentarioModelCompanion(pendingSync: Value(false)),
    );
  }

  Future<void> upsertComentarioFromRemote(
    models.Comentario comentario, {
    required int ticketId,
  }) async {
    await into(comentarioModel).insertOnConflictUpdate(
      ComentarioModelCompanion(
        id: Value(comentario.id),
        contenido: Value(comentario.Contenido),
        ticketId: Value(ticketId),
        pendingSync: const Value(false),
      ),
    );
  }

  Stream<List<models.Ticket>> watchTickets() {
    return (select(ticketModel)
          ..orderBy([(t) => OrderingTerm.desc(t.fechaCreacion)]))
        .watch()
        .asyncMap((rows) => Future.wait(rows.map(_mapTicket)));
  }

  Future<List<models.Ticket>> getAllTickets() async {
    final rows = await select(ticketModel).get();
    return Future.wait(rows.map(_mapTicket));
  }

  Future<List<models.Ticket>> getTicketsByTecnico(int tecnicoId) async {
    final rows = await (select(ticketModel)
          ..where((t) => t.tecnicoId.equals(tecnicoId)))
        .get();
    return Future.wait(rows.map(_mapTicket));
  }

  Future<models.Ticket> insertTicket(models.Ticket ticket) async {
    final insertedId = await into(ticketModel).insert(
      TicketModelCompanion.insert(
        estado: ticket.Estado,
        fechaCreacion: ticket.FechaCreacion,
        prioridad: ticket.Prioridad,
        serialEquipo: ticket.SerialEquipo,
        pendingSync: Value(ticket.pendingSync),
        tecnicoId: ticket.tecnico.id,
        categoriaId: ticket.categoria.id,
        usuarioId: ticket.usuario.id,
      ),
    );
    return ticket.copyWith(id: insertedId);
  }

  Future<void> updateTicket(models.Ticket ticket) async {
    await update(ticketModel).replace(
      TicketModelData(
        id: ticket.id,
        estado: ticket.Estado,
        fechaCreacion: ticket.FechaCreacion,
        prioridad: ticket.Prioridad,
        serialEquipo: ticket.SerialEquipo,
        pendingSync: ticket.pendingSync,
        tecnicoId: ticket.tecnico.id,
        categoriaId: ticket.categoria.id,
        usuarioId: ticket.usuario.id,
      ),
    );
  }

  Future<void> deleteTicket(int id) async {
    await (delete(ticketModel)..where((t) => t.id.equals(id))).go();
  }

  Future<List<models.Ticket>> getPendingTickets() async {
    final rows = await (select(ticketModel)
          ..where((t) => t.pendingSync.equals(true)))
        .get();
    return Future.wait(rows.map(_mapTicket));
  }

  Future<void> markTicketAsSynced(int id) async {
    await (update(ticketModel)..where((t) => t.id.equals(id))).write(
      const TicketModelCompanion(pendingSync: Value(false)),
    );
  }

  Future<void> upsertTicketFromRemote(models.Ticket ticket) async {
    await into(ticketModel).insertOnConflictUpdate(
      TicketModelCompanion(
        id: Value(ticket.id),
        estado: Value(ticket.Estado),
        fechaCreacion: Value(ticket.FechaCreacion),
        prioridad: Value(ticket.Prioridad),
        serialEquipo: Value(ticket.SerialEquipo),
        pendingSync: const Value(false),
        tecnicoId: Value(ticket.tecnico.id),
        categoriaId: Value(ticket.categoria.id),
        usuarioId: Value(ticket.usuario.id),
      ),
    );
  }
}