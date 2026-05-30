// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsuarioModelTable extends UsuarioModel
    with TableInfo<$UsuarioModelTable, UsuarioModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuarioModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentoIdentidadMeta =
      const VerificationMeta('documentoIdentidad');
  @override
  late final GeneratedColumn<int> documentoIdentidad = GeneratedColumn<int>(
    'documento_identidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correoMeta = const VerificationMeta('correo');
  @override
  late final GeneratedColumn<String> correo = GeneratedColumn<String>(
    'correo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
    'rol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    documentoIdentidad,
    correo,
    rol,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuario_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsuarioModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('documento_identidad')) {
      context.handle(
        _documentoIdentidadMeta,
        documentoIdentidad.isAcceptableOrUnknown(
          data['documento_identidad']!,
          _documentoIdentidadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentoIdentidadMeta);
    }
    if (data.containsKey('correo')) {
      context.handle(
        _correoMeta,
        correo.isAcceptableOrUnknown(data['correo']!, _correoMeta),
      );
    } else if (isInserting) {
      context.missing(_correoMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
        _rolMeta,
        rol.isAcceptableOrUnknown(data['rol']!, _rolMeta),
      );
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsuarioModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuarioModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      documentoIdentidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}documento_identidad'],
      )!,
      correo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correo'],
      )!,
      rol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rol'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $UsuarioModelTable createAlias(String alias) {
    return $UsuarioModelTable(attachedDatabase, alias);
  }
}

class UsuarioModelData extends DataClass
    implements Insertable<UsuarioModelData> {
  final int id;
  final String nombre;
  final int documentoIdentidad;
  final String correo;
  final String rol;
  final bool pendingSync;
  const UsuarioModelData({
    required this.id,
    required this.nombre,
    required this.documentoIdentidad,
    required this.correo,
    required this.rol,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['documento_identidad'] = Variable<int>(documentoIdentidad);
    map['correo'] = Variable<String>(correo);
    map['rol'] = Variable<String>(rol);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  UsuarioModelCompanion toCompanion(bool nullToAbsent) {
    return UsuarioModelCompanion(
      id: Value(id),
      nombre: Value(nombre),
      documentoIdentidad: Value(documentoIdentidad),
      correo: Value(correo),
      rol: Value(rol),
      pendingSync: Value(pendingSync),
    );
  }

  factory UsuarioModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuarioModelData(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      documentoIdentidad: serializer.fromJson<int>(json['documentoIdentidad']),
      correo: serializer.fromJson<String>(json['correo']),
      rol: serializer.fromJson<String>(json['rol']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'documentoIdentidad': serializer.toJson<int>(documentoIdentidad),
      'correo': serializer.toJson<String>(correo),
      'rol': serializer.toJson<String>(rol),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  UsuarioModelData copyWith({
    int? id,
    String? nombre,
    int? documentoIdentidad,
    String? correo,
    String? rol,
    bool? pendingSync,
  }) => UsuarioModelData(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    documentoIdentidad: documentoIdentidad ?? this.documentoIdentidad,
    correo: correo ?? this.correo,
    rol: rol ?? this.rol,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  UsuarioModelData copyWithCompanion(UsuarioModelCompanion data) {
    return UsuarioModelData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      documentoIdentidad: data.documentoIdentidad.present
          ? data.documentoIdentidad.value
          : this.documentoIdentidad,
      correo: data.correo.present ? data.correo.value : this.correo,
      rol: data.rol.present ? data.rol.value : this.rol,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioModelData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('documentoIdentidad: $documentoIdentidad, ')
          ..write('correo: $correo, ')
          ..write('rol: $rol, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, documentoIdentidad, correo, rol, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioModelData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.documentoIdentidad == this.documentoIdentidad &&
          other.correo == this.correo &&
          other.rol == this.rol &&
          other.pendingSync == this.pendingSync);
}

class UsuarioModelCompanion extends UpdateCompanion<UsuarioModelData> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<int> documentoIdentidad;
  final Value<String> correo;
  final Value<String> rol;
  final Value<bool> pendingSync;
  const UsuarioModelCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.documentoIdentidad = const Value.absent(),
    this.correo = const Value.absent(),
    this.rol = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  UsuarioModelCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required int documentoIdentidad,
    required String correo,
    required String rol,
    this.pendingSync = const Value.absent(),
  }) : nombre = Value(nombre),
       documentoIdentidad = Value(documentoIdentidad),
       correo = Value(correo),
       rol = Value(rol);
  static Insertable<UsuarioModelData> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? documentoIdentidad,
    Expression<String>? correo,
    Expression<String>? rol,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (documentoIdentidad != null) 'documento_identidad': documentoIdentidad,
      if (correo != null) 'correo': correo,
      if (rol != null) 'rol': rol,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  UsuarioModelCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<int>? documentoIdentidad,
    Value<String>? correo,
    Value<String>? rol,
    Value<bool>? pendingSync,
  }) {
    return UsuarioModelCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      documentoIdentidad: documentoIdentidad ?? this.documentoIdentidad,
      correo: correo ?? this.correo,
      rol: rol ?? this.rol,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (documentoIdentidad.present) {
      map['documento_identidad'] = Variable<int>(documentoIdentidad.value);
    }
    if (correo.present) {
      map['correo'] = Variable<String>(correo.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioModelCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('documentoIdentidad: $documentoIdentidad, ')
          ..write('correo: $correo, ')
          ..write('rol: $rol, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

class $CategoriaModelTable extends CategoriaModel
    with TableInfo<$CategoriaModelTable, CategoriaModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriaModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tiempoRespuestaMeta = const VerificationMeta(
    'tiempoRespuesta',
  );
  @override
  late final GeneratedColumn<String> tiempoRespuesta = GeneratedColumn<String>(
    'tiempo_respuesta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    descripcion,
    tiempoRespuesta,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categoria_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriaModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('tiempo_respuesta')) {
      context.handle(
        _tiempoRespuestaMeta,
        tiempoRespuesta.isAcceptableOrUnknown(
          data['tiempo_respuesta']!,
          _tiempoRespuestaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tiempoRespuestaMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriaModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriaModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      tiempoRespuesta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tiempo_respuesta'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $CategoriaModelTable createAlias(String alias) {
    return $CategoriaModelTable(attachedDatabase, alias);
  }
}

class CategoriaModelData extends DataClass
    implements Insertable<CategoriaModelData> {
  final int id;
  final String nombre;
  final String descripcion;
  final String tiempoRespuesta;
  final bool pendingSync;
  const CategoriaModelData({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tiempoRespuesta,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['tiempo_respuesta'] = Variable<String>(tiempoRespuesta);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  CategoriaModelCompanion toCompanion(bool nullToAbsent) {
    return CategoriaModelCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      tiempoRespuesta: Value(tiempoRespuesta),
      pendingSync: Value(pendingSync),
    );
  }

  factory CategoriaModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriaModelData(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      tiempoRespuesta: serializer.fromJson<String>(json['tiempoRespuesta']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'tiempoRespuesta': serializer.toJson<String>(tiempoRespuesta),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  CategoriaModelData copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? tiempoRespuesta,
    bool? pendingSync,
  }) => CategoriaModelData(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    tiempoRespuesta: tiempoRespuesta ?? this.tiempoRespuesta,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  CategoriaModelData copyWithCompanion(CategoriaModelCompanion data) {
    return CategoriaModelData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      tiempoRespuesta: data.tiempoRespuesta.present
          ? data.tiempoRespuesta.value
          : this.tiempoRespuesta,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriaModelData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('tiempoRespuesta: $tiempoRespuesta, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, descripcion, tiempoRespuesta, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriaModelData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.tiempoRespuesta == this.tiempoRespuesta &&
          other.pendingSync == this.pendingSync);
}

class CategoriaModelCompanion extends UpdateCompanion<CategoriaModelData> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<String> tiempoRespuesta;
  final Value<bool> pendingSync;
  const CategoriaModelCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.tiempoRespuesta = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  CategoriaModelCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String descripcion,
    required String tiempoRespuesta,
    this.pendingSync = const Value.absent(),
  }) : nombre = Value(nombre),
       descripcion = Value(descripcion),
       tiempoRespuesta = Value(tiempoRespuesta);
  static Insertable<CategoriaModelData> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<String>? tiempoRespuesta,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (tiempoRespuesta != null) 'tiempo_respuesta': tiempoRespuesta,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  CategoriaModelCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<String>? tiempoRespuesta,
    Value<bool>? pendingSync,
  }) {
    return CategoriaModelCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      tiempoRespuesta: tiempoRespuesta ?? this.tiempoRespuesta,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (tiempoRespuesta.present) {
      map['tiempo_respuesta'] = Variable<String>(tiempoRespuesta.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriaModelCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('tiempoRespuesta: $tiempoRespuesta, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

class $TecnicoModelTable extends TecnicoModel
    with TableInfo<$TecnicoModelTable, TecnicoModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TecnicoModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentoIdentidadMeta =
      const VerificationMeta('documentoIdentidad');
  @override
  late final GeneratedColumn<int> documentoIdentidad = GeneratedColumn<int>(
    'documento_identidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correoMeta = const VerificationMeta('correo');
  @override
  late final GeneratedColumn<String> correo = GeneratedColumn<String>(
    'correo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    documentoIdentidad,
    correo,
    password,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tecnico_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<TecnicoModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('documento_identidad')) {
      context.handle(
        _documentoIdentidadMeta,
        documentoIdentidad.isAcceptableOrUnknown(
          data['documento_identidad']!,
          _documentoIdentidadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentoIdentidadMeta);
    }
    if (data.containsKey('correo')) {
      context.handle(
        _correoMeta,
        correo.isAcceptableOrUnknown(data['correo']!, _correoMeta),
      );
    } else if (isInserting) {
      context.missing(_correoMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TecnicoModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TecnicoModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      documentoIdentidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}documento_identidad'],
      )!,
      correo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correo'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $TecnicoModelTable createAlias(String alias) {
    return $TecnicoModelTable(attachedDatabase, alias);
  }
}

class TecnicoModelData extends DataClass
    implements Insertable<TecnicoModelData> {
  final int id;
  final String nombre;
  final int documentoIdentidad;
  final String correo;
  final String password;
  final bool pendingSync;
  const TecnicoModelData({
    required this.id,
    required this.nombre,
    required this.documentoIdentidad,
    required this.correo,
    required this.password,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['documento_identidad'] = Variable<int>(documentoIdentidad);
    map['correo'] = Variable<String>(correo);
    map['password'] = Variable<String>(password);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  TecnicoModelCompanion toCompanion(bool nullToAbsent) {
    return TecnicoModelCompanion(
      id: Value(id),
      nombre: Value(nombre),
      documentoIdentidad: Value(documentoIdentidad),
      correo: Value(correo),
      password: Value(password),
      pendingSync: Value(pendingSync),
    );
  }

  factory TecnicoModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TecnicoModelData(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      documentoIdentidad: serializer.fromJson<int>(json['documentoIdentidad']),
      correo: serializer.fromJson<String>(json['correo']),
      password: serializer.fromJson<String>(json['password']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'documentoIdentidad': serializer.toJson<int>(documentoIdentidad),
      'correo': serializer.toJson<String>(correo),
      'password': serializer.toJson<String>(password),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  TecnicoModelData copyWith({
    int? id,
    String? nombre,
    int? documentoIdentidad,
    String? correo,
    String? password,
    bool? pendingSync,
  }) => TecnicoModelData(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    documentoIdentidad: documentoIdentidad ?? this.documentoIdentidad,
    correo: correo ?? this.correo,
    password: password ?? this.password,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  TecnicoModelData copyWithCompanion(TecnicoModelCompanion data) {
    return TecnicoModelData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      documentoIdentidad: data.documentoIdentidad.present
          ? data.documentoIdentidad.value
          : this.documentoIdentidad,
      correo: data.correo.present ? data.correo.value : this.correo,
      password: data.password.present ? data.password.value : this.password,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TecnicoModelData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('documentoIdentidad: $documentoIdentidad, ')
          ..write('correo: $correo, ')
          ..write('password: $password, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    documentoIdentidad,
    correo,
    password,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TecnicoModelData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.documentoIdentidad == this.documentoIdentidad &&
          other.correo == this.correo &&
          other.password == this.password &&
          other.pendingSync == this.pendingSync);
}

class TecnicoModelCompanion extends UpdateCompanion<TecnicoModelData> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<int> documentoIdentidad;
  final Value<String> correo;
  final Value<String> password;
  final Value<bool> pendingSync;
  const TecnicoModelCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.documentoIdentidad = const Value.absent(),
    this.correo = const Value.absent(),
    this.password = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  TecnicoModelCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required int documentoIdentidad,
    required String correo,
    required String password,
    this.pendingSync = const Value.absent(),
  }) : nombre = Value(nombre),
       documentoIdentidad = Value(documentoIdentidad),
       correo = Value(correo),
       password = Value(password);
  static Insertable<TecnicoModelData> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? documentoIdentidad,
    Expression<String>? correo,
    Expression<String>? password,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (documentoIdentidad != null) 'documento_identidad': documentoIdentidad,
      if (correo != null) 'correo': correo,
      if (password != null) 'password': password,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  TecnicoModelCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<int>? documentoIdentidad,
    Value<String>? correo,
    Value<String>? password,
    Value<bool>? pendingSync,
  }) {
    return TecnicoModelCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      documentoIdentidad: documentoIdentidad ?? this.documentoIdentidad,
      correo: correo ?? this.correo,
      password: password ?? this.password,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (documentoIdentidad.present) {
      map['documento_identidad'] = Variable<int>(documentoIdentidad.value);
    }
    if (correo.present) {
      map['correo'] = Variable<String>(correo.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TecnicoModelCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('documentoIdentidad: $documentoIdentidad, ')
          ..write('correo: $correo, ')
          ..write('password: $password, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

class $TicketModelTable extends TicketModel
    with TableInfo<$TicketModelTable, TicketModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TicketModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaCreacionMeta = const VerificationMeta(
    'fechaCreacion',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>(
        'fecha_creacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _prioridadMeta = const VerificationMeta(
    'prioridad',
  );
  @override
  late final GeneratedColumn<String> prioridad = GeneratedColumn<String>(
    'prioridad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serialEquipoMeta = const VerificationMeta(
    'serialEquipo',
  );
  @override
  late final GeneratedColumn<String> serialEquipo = GeneratedColumn<String>(
    'serial_equipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _tecnicoIdMeta = const VerificationMeta(
    'tecnicoId',
  );
  @override
  late final GeneratedColumn<int> tecnicoId = GeneratedColumn<int>(
    'tecnico_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tecnico_model (id)',
    ),
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
    'categoria_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categoria_model (id)',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuario_model (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    estado,
    fechaCreacion,
    prioridad,
    serialEquipo,
    pendingSync,
    tecnicoId,
    categoriaId,
    usuarioId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ticket_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<TicketModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
        _fechaCreacionMeta,
        fechaCreacion.isAcceptableOrUnknown(
          data['fecha_creacion']!,
          _fechaCreacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    if (data.containsKey('prioridad')) {
      context.handle(
        _prioridadMeta,
        prioridad.isAcceptableOrUnknown(data['prioridad']!, _prioridadMeta),
      );
    } else if (isInserting) {
      context.missing(_prioridadMeta);
    }
    if (data.containsKey('serial_equipo')) {
      context.handle(
        _serialEquipoMeta,
        serialEquipo.isAcceptableOrUnknown(
          data['serial_equipo']!,
          _serialEquipoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serialEquipoMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    if (data.containsKey('tecnico_id')) {
      context.handle(
        _tecnicoIdMeta,
        tecnicoId.isAcceptableOrUnknown(data['tecnico_id']!, _tecnicoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tecnicoIdMeta);
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoriaIdMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TicketModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TicketModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      fechaCreacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_creacion'],
      )!,
      prioridad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prioridad'],
      )!,
      serialEquipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_equipo'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
      tecnicoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tecnico_id'],
      )!,
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categoria_id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
    );
  }

  @override
  $TicketModelTable createAlias(String alias) {
    return $TicketModelTable(attachedDatabase, alias);
  }
}

class TicketModelData extends DataClass implements Insertable<TicketModelData> {
  final int id;
  final String estado;
  final DateTime fechaCreacion;
  final String prioridad;
  final String serialEquipo;
  final bool pendingSync;
  final int tecnicoId;
  final int categoriaId;
  final int usuarioId;
  const TicketModelData({
    required this.id,
    required this.estado,
    required this.fechaCreacion,
    required this.prioridad,
    required this.serialEquipo,
    required this.pendingSync,
    required this.tecnicoId,
    required this.categoriaId,
    required this.usuarioId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<String>(estado);
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    map['prioridad'] = Variable<String>(prioridad);
    map['serial_equipo'] = Variable<String>(serialEquipo);
    map['pending_sync'] = Variable<bool>(pendingSync);
    map['tecnico_id'] = Variable<int>(tecnicoId);
    map['categoria_id'] = Variable<int>(categoriaId);
    map['usuario_id'] = Variable<int>(usuarioId);
    return map;
  }

  TicketModelCompanion toCompanion(bool nullToAbsent) {
    return TicketModelCompanion(
      id: Value(id),
      estado: Value(estado),
      fechaCreacion: Value(fechaCreacion),
      prioridad: Value(prioridad),
      serialEquipo: Value(serialEquipo),
      pendingSync: Value(pendingSync),
      tecnicoId: Value(tecnicoId),
      categoriaId: Value(categoriaId),
      usuarioId: Value(usuarioId),
    );
  }

  factory TicketModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TicketModelData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<String>(json['estado']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
      prioridad: serializer.fromJson<String>(json['prioridad']),
      serialEquipo: serializer.fromJson<String>(json['serialEquipo']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
      tecnicoId: serializer.fromJson<int>(json['tecnicoId']),
      categoriaId: serializer.fromJson<int>(json['categoriaId']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<String>(estado),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
      'prioridad': serializer.toJson<String>(prioridad),
      'serialEquipo': serializer.toJson<String>(serialEquipo),
      'pendingSync': serializer.toJson<bool>(pendingSync),
      'tecnicoId': serializer.toJson<int>(tecnicoId),
      'categoriaId': serializer.toJson<int>(categoriaId),
      'usuarioId': serializer.toJson<int>(usuarioId),
    };
  }

  TicketModelData copyWith({
    int? id,
    String? estado,
    DateTime? fechaCreacion,
    String? prioridad,
    String? serialEquipo,
    bool? pendingSync,
    int? tecnicoId,
    int? categoriaId,
    int? usuarioId,
  }) => TicketModelData(
    id: id ?? this.id,
    estado: estado ?? this.estado,
    fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    prioridad: prioridad ?? this.prioridad,
    serialEquipo: serialEquipo ?? this.serialEquipo,
    pendingSync: pendingSync ?? this.pendingSync,
    tecnicoId: tecnicoId ?? this.tecnicoId,
    categoriaId: categoriaId ?? this.categoriaId,
    usuarioId: usuarioId ?? this.usuarioId,
  );
  TicketModelData copyWithCompanion(TicketModelCompanion data) {
    return TicketModelData(
      id: data.id.present ? data.id.value : this.id,
      estado: data.estado.present ? data.estado.value : this.estado,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
      prioridad: data.prioridad.present ? data.prioridad.value : this.prioridad,
      serialEquipo: data.serialEquipo.present
          ? data.serialEquipo.value
          : this.serialEquipo,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
      tecnicoId: data.tecnicoId.present ? data.tecnicoId.value : this.tecnicoId,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TicketModelData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('prioridad: $prioridad, ')
          ..write('serialEquipo: $serialEquipo, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('usuarioId: $usuarioId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    estado,
    fechaCreacion,
    prioridad,
    serialEquipo,
    pendingSync,
    tecnicoId,
    categoriaId,
    usuarioId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TicketModelData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.fechaCreacion == this.fechaCreacion &&
          other.prioridad == this.prioridad &&
          other.serialEquipo == this.serialEquipo &&
          other.pendingSync == this.pendingSync &&
          other.tecnicoId == this.tecnicoId &&
          other.categoriaId == this.categoriaId &&
          other.usuarioId == this.usuarioId);
}

class TicketModelCompanion extends UpdateCompanion<TicketModelData> {
  final Value<int> id;
  final Value<String> estado;
  final Value<DateTime> fechaCreacion;
  final Value<String> prioridad;
  final Value<String> serialEquipo;
  final Value<bool> pendingSync;
  final Value<int> tecnicoId;
  final Value<int> categoriaId;
  final Value<int> usuarioId;
  const TicketModelCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.prioridad = const Value.absent(),
    this.serialEquipo = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.tecnicoId = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.usuarioId = const Value.absent(),
  });
  TicketModelCompanion.insert({
    this.id = const Value.absent(),
    required String estado,
    required DateTime fechaCreacion,
    required String prioridad,
    required String serialEquipo,
    this.pendingSync = const Value.absent(),
    required int tecnicoId,
    required int categoriaId,
    required int usuarioId,
  }) : estado = Value(estado),
       fechaCreacion = Value(fechaCreacion),
       prioridad = Value(prioridad),
       serialEquipo = Value(serialEquipo),
       tecnicoId = Value(tecnicoId),
       categoriaId = Value(categoriaId),
       usuarioId = Value(usuarioId);
  static Insertable<TicketModelData> custom({
    Expression<int>? id,
    Expression<String>? estado,
    Expression<DateTime>? fechaCreacion,
    Expression<String>? prioridad,
    Expression<String>? serialEquipo,
    Expression<bool>? pendingSync,
    Expression<int>? tecnicoId,
    Expression<int>? categoriaId,
    Expression<int>? usuarioId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (prioridad != null) 'prioridad': prioridad,
      if (serialEquipo != null) 'serial_equipo': serialEquipo,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (tecnicoId != null) 'tecnico_id': tecnicoId,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (usuarioId != null) 'usuario_id': usuarioId,
    });
  }

  TicketModelCompanion copyWith({
    Value<int>? id,
    Value<String>? estado,
    Value<DateTime>? fechaCreacion,
    Value<String>? prioridad,
    Value<String>? serialEquipo,
    Value<bool>? pendingSync,
    Value<int>? tecnicoId,
    Value<int>? categoriaId,
    Value<int>? usuarioId,
  }) {
    return TicketModelCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      prioridad: prioridad ?? this.prioridad,
      serialEquipo: serialEquipo ?? this.serialEquipo,
      pendingSync: pendingSync ?? this.pendingSync,
      tecnicoId: tecnicoId ?? this.tecnicoId,
      categoriaId: categoriaId ?? this.categoriaId,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    if (prioridad.present) {
      map['prioridad'] = Variable<String>(prioridad.value);
    }
    if (serialEquipo.present) {
      map['serial_equipo'] = Variable<String>(serialEquipo.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (tecnicoId.present) {
      map['tecnico_id'] = Variable<int>(tecnicoId.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TicketModelCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('prioridad: $prioridad, ')
          ..write('serialEquipo: $serialEquipo, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('usuarioId: $usuarioId')
          ..write(')'))
        .toString();
  }
}

class $ComentarioModelTable extends ComentarioModel
    with TableInfo<$ComentarioModelTable, ComentarioModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComentarioModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contenidoMeta = const VerificationMeta(
    'contenido',
  );
  @override
  late final GeneratedColumn<String> contenido = GeneratedColumn<String>(
    'contenido',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ticketIdMeta = const VerificationMeta(
    'ticketId',
  );
  @override
  late final GeneratedColumn<int> ticketId = GeneratedColumn<int>(
    'ticket_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ticket_model (id)',
    ),
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, contenido, ticketId, pendingSync];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'comentario_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComentarioModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('contenido')) {
      context.handle(
        _contenidoMeta,
        contenido.isAcceptableOrUnknown(data['contenido']!, _contenidoMeta),
      );
    } else if (isInserting) {
      context.missing(_contenidoMeta);
    }
    if (data.containsKey('ticket_id')) {
      context.handle(
        _ticketIdMeta,
        ticketId.isAcceptableOrUnknown(data['ticket_id']!, _ticketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ticketIdMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComentarioModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComentarioModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contenido: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contenido'],
      )!,
      ticketId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ticket_id'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $ComentarioModelTable createAlias(String alias) {
    return $ComentarioModelTable(attachedDatabase, alias);
  }
}

class ComentarioModelData extends DataClass
    implements Insertable<ComentarioModelData> {
  final int id;
  final String contenido;
  final int ticketId;
  final bool pendingSync;
  const ComentarioModelData({
    required this.id,
    required this.contenido,
    required this.ticketId,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['contenido'] = Variable<String>(contenido);
    map['ticket_id'] = Variable<int>(ticketId);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  ComentarioModelCompanion toCompanion(bool nullToAbsent) {
    return ComentarioModelCompanion(
      id: Value(id),
      contenido: Value(contenido),
      ticketId: Value(ticketId),
      pendingSync: Value(pendingSync),
    );
  }

  factory ComentarioModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComentarioModelData(
      id: serializer.fromJson<int>(json['id']),
      contenido: serializer.fromJson<String>(json['contenido']),
      ticketId: serializer.fromJson<int>(json['ticketId']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contenido': serializer.toJson<String>(contenido),
      'ticketId': serializer.toJson<int>(ticketId),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  ComentarioModelData copyWith({
    int? id,
    String? contenido,
    int? ticketId,
    bool? pendingSync,
  }) => ComentarioModelData(
    id: id ?? this.id,
    contenido: contenido ?? this.contenido,
    ticketId: ticketId ?? this.ticketId,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  ComentarioModelData copyWithCompanion(ComentarioModelCompanion data) {
    return ComentarioModelData(
      id: data.id.present ? data.id.value : this.id,
      contenido: data.contenido.present ? data.contenido.value : this.contenido,
      ticketId: data.ticketId.present ? data.ticketId.value : this.ticketId,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComentarioModelData(')
          ..write('id: $id, ')
          ..write('contenido: $contenido, ')
          ..write('ticketId: $ticketId, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contenido, ticketId, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComentarioModelData &&
          other.id == this.id &&
          other.contenido == this.contenido &&
          other.ticketId == this.ticketId &&
          other.pendingSync == this.pendingSync);
}

class ComentarioModelCompanion extends UpdateCompanion<ComentarioModelData> {
  final Value<int> id;
  final Value<String> contenido;
  final Value<int> ticketId;
  final Value<bool> pendingSync;
  const ComentarioModelCompanion({
    this.id = const Value.absent(),
    this.contenido = const Value.absent(),
    this.ticketId = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  ComentarioModelCompanion.insert({
    this.id = const Value.absent(),
    required String contenido,
    required int ticketId,
    this.pendingSync = const Value.absent(),
  }) : contenido = Value(contenido),
       ticketId = Value(ticketId);
  static Insertable<ComentarioModelData> custom({
    Expression<int>? id,
    Expression<String>? contenido,
    Expression<int>? ticketId,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contenido != null) 'contenido': contenido,
      if (ticketId != null) 'ticket_id': ticketId,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  ComentarioModelCompanion copyWith({
    Value<int>? id,
    Value<String>? contenido,
    Value<int>? ticketId,
    Value<bool>? pendingSync,
  }) {
    return ComentarioModelCompanion(
      id: id ?? this.id,
      contenido: contenido ?? this.contenido,
      ticketId: ticketId ?? this.ticketId,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contenido.present) {
      map['contenido'] = Variable<String>(contenido.value);
    }
    if (ticketId.present) {
      map['ticket_id'] = Variable<int>(ticketId.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComentarioModelCompanion(')
          ..write('id: $id, ')
          ..write('contenido: $contenido, ')
          ..write('ticketId: $ticketId, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuarioModelTable usuarioModel = $UsuarioModelTable(this);
  late final $CategoriaModelTable categoriaModel = $CategoriaModelTable(this);
  late final $TecnicoModelTable tecnicoModel = $TecnicoModelTable(this);
  late final $TicketModelTable ticketModel = $TicketModelTable(this);
  late final $ComentarioModelTable comentarioModel = $ComentarioModelTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarioModel,
    categoriaModel,
    tecnicoModel,
    ticketModel,
    comentarioModel,
  ];
}

typedef $$UsuarioModelTableCreateCompanionBuilder =
    UsuarioModelCompanion Function({
      Value<int> id,
      required String nombre,
      required int documentoIdentidad,
      required String correo,
      required String rol,
      Value<bool> pendingSync,
    });
typedef $$UsuarioModelTableUpdateCompanionBuilder =
    UsuarioModelCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<int> documentoIdentidad,
      Value<String> correo,
      Value<String> rol,
      Value<bool> pendingSync,
    });

final class $$UsuarioModelTableReferences
    extends
        BaseReferences<_$AppDatabase, $UsuarioModelTable, UsuarioModelData> {
  $$UsuarioModelTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TicketModelTable, List<TicketModelData>>
  _ticketModelRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ticketModel,
    aliasName: $_aliasNameGenerator(
      db.usuarioModel.id,
      db.ticketModel.usuarioId,
    ),
  );

  $$TicketModelTableProcessedTableManager get ticketModelRefs {
    final manager = $$TicketModelTableTableManager(
      $_db,
      $_db.ticketModel,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ticketModelRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuarioModelTableFilterComposer
    extends Composer<_$AppDatabase, $UsuarioModelTable> {
  $$UsuarioModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get documentoIdentidad => $composableBuilder(
    column: $table.documentoIdentidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ticketModelRefs(
    Expression<bool> Function($$TicketModelTableFilterComposer f) f,
  ) {
    final $$TicketModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableFilterComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuarioModelTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuarioModelTable> {
  $$UsuarioModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get documentoIdentidad => $composableBuilder(
    column: $table.documentoIdentidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuarioModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuarioModelTable> {
  $$UsuarioModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get documentoIdentidad => $composableBuilder(
    column: $table.documentoIdentidad,
    builder: (column) => column,
  );

  GeneratedColumn<String> get correo =>
      $composableBuilder(column: $table.correo, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  Expression<T> ticketModelRefs<T extends Object>(
    Expression<T> Function($$TicketModelTableAnnotationComposer a) f,
  ) {
    final $$TicketModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableAnnotationComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuarioModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuarioModelTable,
          UsuarioModelData,
          $$UsuarioModelTableFilterComposer,
          $$UsuarioModelTableOrderingComposer,
          $$UsuarioModelTableAnnotationComposer,
          $$UsuarioModelTableCreateCompanionBuilder,
          $$UsuarioModelTableUpdateCompanionBuilder,
          (UsuarioModelData, $$UsuarioModelTableReferences),
          UsuarioModelData,
          PrefetchHooks Function({bool ticketModelRefs})
        > {
  $$UsuarioModelTableTableManager(_$AppDatabase db, $UsuarioModelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuarioModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuarioModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuarioModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> documentoIdentidad = const Value.absent(),
                Value<String> correo = const Value.absent(),
                Value<String> rol = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
              }) => UsuarioModelCompanion(
                id: id,
                nombre: nombre,
                documentoIdentidad: documentoIdentidad,
                correo: correo,
                rol: rol,
                pendingSync: pendingSync,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required int documentoIdentidad,
                required String correo,
                required String rol,
                Value<bool> pendingSync = const Value.absent(),
              }) => UsuarioModelCompanion.insert(
                id: id,
                nombre: nombre,
                documentoIdentidad: documentoIdentidad,
                correo: correo,
                rol: rol,
                pendingSync: pendingSync,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuarioModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ticketModelRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ticketModelRefs) db.ticketModel],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ticketModelRefs)
                    await $_getPrefetchedData<
                      UsuarioModelData,
                      $UsuarioModelTable,
                      TicketModelData
                    >(
                      currentTable: table,
                      referencedTable: $$UsuarioModelTableReferences
                          ._ticketModelRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsuarioModelTableReferences(
                            db,
                            table,
                            p0,
                          ).ticketModelRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.usuarioId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsuarioModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuarioModelTable,
      UsuarioModelData,
      $$UsuarioModelTableFilterComposer,
      $$UsuarioModelTableOrderingComposer,
      $$UsuarioModelTableAnnotationComposer,
      $$UsuarioModelTableCreateCompanionBuilder,
      $$UsuarioModelTableUpdateCompanionBuilder,
      (UsuarioModelData, $$UsuarioModelTableReferences),
      UsuarioModelData,
      PrefetchHooks Function({bool ticketModelRefs})
    >;
typedef $$CategoriaModelTableCreateCompanionBuilder =
    CategoriaModelCompanion Function({
      Value<int> id,
      required String nombre,
      required String descripcion,
      required String tiempoRespuesta,
      Value<bool> pendingSync,
    });
typedef $$CategoriaModelTableUpdateCompanionBuilder =
    CategoriaModelCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> descripcion,
      Value<String> tiempoRespuesta,
      Value<bool> pendingSync,
    });

final class $$CategoriaModelTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CategoriaModelTable,
          CategoriaModelData
        > {
  $$CategoriaModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TicketModelTable, List<TicketModelData>>
  _ticketModelRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ticketModel,
    aliasName: $_aliasNameGenerator(
      db.categoriaModel.id,
      db.ticketModel.categoriaId,
    ),
  );

  $$TicketModelTableProcessedTableManager get ticketModelRefs {
    final manager = $$TicketModelTableTableManager(
      $_db,
      $_db.ticketModel,
    ).filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ticketModelRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriaModelTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriaModelTable> {
  $$CategoriaModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tiempoRespuesta => $composableBuilder(
    column: $table.tiempoRespuesta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ticketModelRefs(
    Expression<bool> Function($$TicketModelTableFilterComposer f) f,
  ) {
    final $$TicketModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableFilterComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriaModelTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriaModelTable> {
  $$CategoriaModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tiempoRespuesta => $composableBuilder(
    column: $table.tiempoRespuesta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriaModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriaModelTable> {
  $$CategoriaModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tiempoRespuesta => $composableBuilder(
    column: $table.tiempoRespuesta,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  Expression<T> ticketModelRefs<T extends Object>(
    Expression<T> Function($$TicketModelTableAnnotationComposer a) f,
  ) {
    final $$TicketModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableAnnotationComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriaModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriaModelTable,
          CategoriaModelData,
          $$CategoriaModelTableFilterComposer,
          $$CategoriaModelTableOrderingComposer,
          $$CategoriaModelTableAnnotationComposer,
          $$CategoriaModelTableCreateCompanionBuilder,
          $$CategoriaModelTableUpdateCompanionBuilder,
          (CategoriaModelData, $$CategoriaModelTableReferences),
          CategoriaModelData,
          PrefetchHooks Function({bool ticketModelRefs})
        > {
  $$CategoriaModelTableTableManager(
    _$AppDatabase db,
    $CategoriaModelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriaModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriaModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriaModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String> tiempoRespuesta = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
              }) => CategoriaModelCompanion(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                tiempoRespuesta: tiempoRespuesta,
                pendingSync: pendingSync,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String descripcion,
                required String tiempoRespuesta,
                Value<bool> pendingSync = const Value.absent(),
              }) => CategoriaModelCompanion.insert(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                tiempoRespuesta: tiempoRespuesta,
                pendingSync: pendingSync,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriaModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ticketModelRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ticketModelRefs) db.ticketModel],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ticketModelRefs)
                    await $_getPrefetchedData<
                      CategoriaModelData,
                      $CategoriaModelTable,
                      TicketModelData
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriaModelTableReferences
                          ._ticketModelRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriaModelTableReferences(
                            db,
                            table,
                            p0,
                          ).ticketModelRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.categoriaId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriaModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriaModelTable,
      CategoriaModelData,
      $$CategoriaModelTableFilterComposer,
      $$CategoriaModelTableOrderingComposer,
      $$CategoriaModelTableAnnotationComposer,
      $$CategoriaModelTableCreateCompanionBuilder,
      $$CategoriaModelTableUpdateCompanionBuilder,
      (CategoriaModelData, $$CategoriaModelTableReferences),
      CategoriaModelData,
      PrefetchHooks Function({bool ticketModelRefs})
    >;
typedef $$TecnicoModelTableCreateCompanionBuilder =
    TecnicoModelCompanion Function({
      Value<int> id,
      required String nombre,
      required int documentoIdentidad,
      required String correo,
      required String password,
      Value<bool> pendingSync,
    });
typedef $$TecnicoModelTableUpdateCompanionBuilder =
    TecnicoModelCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<int> documentoIdentidad,
      Value<String> correo,
      Value<String> password,
      Value<bool> pendingSync,
    });

final class $$TecnicoModelTableReferences
    extends
        BaseReferences<_$AppDatabase, $TecnicoModelTable, TecnicoModelData> {
  $$TecnicoModelTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TicketModelTable, List<TicketModelData>>
  _ticketModelRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ticketModel,
    aliasName: $_aliasNameGenerator(
      db.tecnicoModel.id,
      db.ticketModel.tecnicoId,
    ),
  );

  $$TicketModelTableProcessedTableManager get ticketModelRefs {
    final manager = $$TicketModelTableTableManager(
      $_db,
      $_db.ticketModel,
    ).filter((f) => f.tecnicoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ticketModelRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TecnicoModelTableFilterComposer
    extends Composer<_$AppDatabase, $TecnicoModelTable> {
  $$TecnicoModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get documentoIdentidad => $composableBuilder(
    column: $table.documentoIdentidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ticketModelRefs(
    Expression<bool> Function($$TicketModelTableFilterComposer f) f,
  ) {
    final $$TicketModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.tecnicoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableFilterComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TecnicoModelTableOrderingComposer
    extends Composer<_$AppDatabase, $TecnicoModelTable> {
  $$TecnicoModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get documentoIdentidad => $composableBuilder(
    column: $table.documentoIdentidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TecnicoModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $TecnicoModelTable> {
  $$TecnicoModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get documentoIdentidad => $composableBuilder(
    column: $table.documentoIdentidad,
    builder: (column) => column,
  );

  GeneratedColumn<String> get correo =>
      $composableBuilder(column: $table.correo, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  Expression<T> ticketModelRefs<T extends Object>(
    Expression<T> Function($$TicketModelTableAnnotationComposer a) f,
  ) {
    final $$TicketModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.tecnicoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableAnnotationComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TecnicoModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TecnicoModelTable,
          TecnicoModelData,
          $$TecnicoModelTableFilterComposer,
          $$TecnicoModelTableOrderingComposer,
          $$TecnicoModelTableAnnotationComposer,
          $$TecnicoModelTableCreateCompanionBuilder,
          $$TecnicoModelTableUpdateCompanionBuilder,
          (TecnicoModelData, $$TecnicoModelTableReferences),
          TecnicoModelData,
          PrefetchHooks Function({bool ticketModelRefs})
        > {
  $$TecnicoModelTableTableManager(_$AppDatabase db, $TecnicoModelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TecnicoModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TecnicoModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TecnicoModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> documentoIdentidad = const Value.absent(),
                Value<String> correo = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
              }) => TecnicoModelCompanion(
                id: id,
                nombre: nombre,
                documentoIdentidad: documentoIdentidad,
                correo: correo,
                password: password,
                pendingSync: pendingSync,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required int documentoIdentidad,
                required String correo,
                required String password,
                Value<bool> pendingSync = const Value.absent(),
              }) => TecnicoModelCompanion.insert(
                id: id,
                nombre: nombre,
                documentoIdentidad: documentoIdentidad,
                correo: correo,
                password: password,
                pendingSync: pendingSync,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TecnicoModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ticketModelRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ticketModelRefs) db.ticketModel],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ticketModelRefs)
                    await $_getPrefetchedData<
                      TecnicoModelData,
                      $TecnicoModelTable,
                      TicketModelData
                    >(
                      currentTable: table,
                      referencedTable: $$TecnicoModelTableReferences
                          ._ticketModelRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TecnicoModelTableReferences(
                            db,
                            table,
                            p0,
                          ).ticketModelRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tecnicoId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TecnicoModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TecnicoModelTable,
      TecnicoModelData,
      $$TecnicoModelTableFilterComposer,
      $$TecnicoModelTableOrderingComposer,
      $$TecnicoModelTableAnnotationComposer,
      $$TecnicoModelTableCreateCompanionBuilder,
      $$TecnicoModelTableUpdateCompanionBuilder,
      (TecnicoModelData, $$TecnicoModelTableReferences),
      TecnicoModelData,
      PrefetchHooks Function({bool ticketModelRefs})
    >;
typedef $$TicketModelTableCreateCompanionBuilder =
    TicketModelCompanion Function({
      Value<int> id,
      required String estado,
      required DateTime fechaCreacion,
      required String prioridad,
      required String serialEquipo,
      Value<bool> pendingSync,
      required int tecnicoId,
      required int categoriaId,
      required int usuarioId,
    });
typedef $$TicketModelTableUpdateCompanionBuilder =
    TicketModelCompanion Function({
      Value<int> id,
      Value<String> estado,
      Value<DateTime> fechaCreacion,
      Value<String> prioridad,
      Value<String> serialEquipo,
      Value<bool> pendingSync,
      Value<int> tecnicoId,
      Value<int> categoriaId,
      Value<int> usuarioId,
    });

final class $$TicketModelTableReferences
    extends BaseReferences<_$AppDatabase, $TicketModelTable, TicketModelData> {
  $$TicketModelTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TecnicoModelTable _tecnicoIdTable(_$AppDatabase db) =>
      db.tecnicoModel.createAlias(
        $_aliasNameGenerator(db.ticketModel.tecnicoId, db.tecnicoModel.id),
      );

  $$TecnicoModelTableProcessedTableManager get tecnicoId {
    final $_column = $_itemColumn<int>('tecnico_id')!;

    final manager = $$TecnicoModelTableTableManager(
      $_db,
      $_db.tecnicoModel,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tecnicoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriaModelTable _categoriaIdTable(_$AppDatabase db) =>
      db.categoriaModel.createAlias(
        $_aliasNameGenerator(db.ticketModel.categoriaId, db.categoriaModel.id),
      );

  $$CategoriaModelTableProcessedTableManager get categoriaId {
    final $_column = $_itemColumn<int>('categoria_id')!;

    final manager = $$CategoriaModelTableTableManager(
      $_db,
      $_db.categoriaModel,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuarioModelTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarioModel.createAlias(
        $_aliasNameGenerator(db.ticketModel.usuarioId, db.usuarioModel.id),
      );

  $$UsuarioModelTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuarioModelTableTableManager(
      $_db,
      $_db.usuarioModel,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ComentarioModelTable, List<ComentarioModelData>>
  _comentarioModelRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.comentarioModel,
    aliasName: $_aliasNameGenerator(
      db.ticketModel.id,
      db.comentarioModel.ticketId,
    ),
  );

  $$ComentarioModelTableProcessedTableManager get comentarioModelRefs {
    final manager = $$ComentarioModelTableTableManager(
      $_db,
      $_db.comentarioModel,
    ).filter((f) => f.ticketId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _comentarioModelRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TicketModelTableFilterComposer
    extends Composer<_$AppDatabase, $TicketModelTable> {
  $$TicketModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialEquipo => $composableBuilder(
    column: $table.serialEquipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  $$TecnicoModelTableFilterComposer get tecnicoId {
    final $$TecnicoModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tecnicoId,
      referencedTable: $db.tecnicoModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TecnicoModelTableFilterComposer(
            $db: $db,
            $table: $db.tecnicoModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriaModelTableFilterComposer get categoriaId {
    final $$CategoriaModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categoriaModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriaModelTableFilterComposer(
            $db: $db,
            $table: $db.categoriaModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuarioModelTableFilterComposer get usuarioId {
    final $$UsuarioModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarioModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuarioModelTableFilterComposer(
            $db: $db,
            $table: $db.usuarioModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> comentarioModelRefs(
    Expression<bool> Function($$ComentarioModelTableFilterComposer f) f,
  ) {
    final $$ComentarioModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.comentarioModel,
      getReferencedColumn: (t) => t.ticketId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComentarioModelTableFilterComposer(
            $db: $db,
            $table: $db.comentarioModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TicketModelTableOrderingComposer
    extends Composer<_$AppDatabase, $TicketModelTable> {
  $$TicketModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialEquipo => $composableBuilder(
    column: $table.serialEquipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  $$TecnicoModelTableOrderingComposer get tecnicoId {
    final $$TecnicoModelTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tecnicoId,
      referencedTable: $db.tecnicoModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TecnicoModelTableOrderingComposer(
            $db: $db,
            $table: $db.tecnicoModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriaModelTableOrderingComposer get categoriaId {
    final $$CategoriaModelTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categoriaModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriaModelTableOrderingComposer(
            $db: $db,
            $table: $db.categoriaModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuarioModelTableOrderingComposer get usuarioId {
    final $$UsuarioModelTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarioModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuarioModelTableOrderingComposer(
            $db: $db,
            $table: $db.usuarioModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TicketModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $TicketModelTable> {
  $$TicketModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prioridad =>
      $composableBuilder(column: $table.prioridad, builder: (column) => column);

  GeneratedColumn<String> get serialEquipo => $composableBuilder(
    column: $table.serialEquipo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  $$TecnicoModelTableAnnotationComposer get tecnicoId {
    final $$TecnicoModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tecnicoId,
      referencedTable: $db.tecnicoModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TecnicoModelTableAnnotationComposer(
            $db: $db,
            $table: $db.tecnicoModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriaModelTableAnnotationComposer get categoriaId {
    final $$CategoriaModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categoriaModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriaModelTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriaModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuarioModelTableAnnotationComposer get usuarioId {
    final $$UsuarioModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarioModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuarioModelTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarioModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> comentarioModelRefs<T extends Object>(
    Expression<T> Function($$ComentarioModelTableAnnotationComposer a) f,
  ) {
    final $$ComentarioModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.comentarioModel,
      getReferencedColumn: (t) => t.ticketId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComentarioModelTableAnnotationComposer(
            $db: $db,
            $table: $db.comentarioModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TicketModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TicketModelTable,
          TicketModelData,
          $$TicketModelTableFilterComposer,
          $$TicketModelTableOrderingComposer,
          $$TicketModelTableAnnotationComposer,
          $$TicketModelTableCreateCompanionBuilder,
          $$TicketModelTableUpdateCompanionBuilder,
          (TicketModelData, $$TicketModelTableReferences),
          TicketModelData,
          PrefetchHooks Function({
            bool tecnicoId,
            bool categoriaId,
            bool usuarioId,
            bool comentarioModelRefs,
          })
        > {
  $$TicketModelTableTableManager(_$AppDatabase db, $TicketModelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TicketModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TicketModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TicketModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<DateTime> fechaCreacion = const Value.absent(),
                Value<String> prioridad = const Value.absent(),
                Value<String> serialEquipo = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> tecnicoId = const Value.absent(),
                Value<int> categoriaId = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
              }) => TicketModelCompanion(
                id: id,
                estado: estado,
                fechaCreacion: fechaCreacion,
                prioridad: prioridad,
                serialEquipo: serialEquipo,
                pendingSync: pendingSync,
                tecnicoId: tecnicoId,
                categoriaId: categoriaId,
                usuarioId: usuarioId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String estado,
                required DateTime fechaCreacion,
                required String prioridad,
                required String serialEquipo,
                Value<bool> pendingSync = const Value.absent(),
                required int tecnicoId,
                required int categoriaId,
                required int usuarioId,
              }) => TicketModelCompanion.insert(
                id: id,
                estado: estado,
                fechaCreacion: fechaCreacion,
                prioridad: prioridad,
                serialEquipo: serialEquipo,
                pendingSync: pendingSync,
                tecnicoId: tecnicoId,
                categoriaId: categoriaId,
                usuarioId: usuarioId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TicketModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tecnicoId = false,
                categoriaId = false,
                usuarioId = false,
                comentarioModelRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (comentarioModelRefs) db.comentarioModel,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tecnicoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tecnicoId,
                                    referencedTable:
                                        $$TicketModelTableReferences
                                            ._tecnicoIdTable(db),
                                    referencedColumn:
                                        $$TicketModelTableReferences
                                            ._tecnicoIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoriaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoriaId,
                                    referencedTable:
                                        $$TicketModelTableReferences
                                            ._categoriaIdTable(db),
                                    referencedColumn:
                                        $$TicketModelTableReferences
                                            ._categoriaIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (usuarioId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.usuarioId,
                                    referencedTable:
                                        $$TicketModelTableReferences
                                            ._usuarioIdTable(db),
                                    referencedColumn:
                                        $$TicketModelTableReferences
                                            ._usuarioIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (comentarioModelRefs)
                        await $_getPrefetchedData<
                          TicketModelData,
                          $TicketModelTable,
                          ComentarioModelData
                        >(
                          currentTable: table,
                          referencedTable: $$TicketModelTableReferences
                              ._comentarioModelRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TicketModelTableReferences(
                                db,
                                table,
                                p0,
                              ).comentarioModelRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ticketId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TicketModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TicketModelTable,
      TicketModelData,
      $$TicketModelTableFilterComposer,
      $$TicketModelTableOrderingComposer,
      $$TicketModelTableAnnotationComposer,
      $$TicketModelTableCreateCompanionBuilder,
      $$TicketModelTableUpdateCompanionBuilder,
      (TicketModelData, $$TicketModelTableReferences),
      TicketModelData,
      PrefetchHooks Function({
        bool tecnicoId,
        bool categoriaId,
        bool usuarioId,
        bool comentarioModelRefs,
      })
    >;
typedef $$ComentarioModelTableCreateCompanionBuilder =
    ComentarioModelCompanion Function({
      Value<int> id,
      required String contenido,
      required int ticketId,
      Value<bool> pendingSync,
    });
typedef $$ComentarioModelTableUpdateCompanionBuilder =
    ComentarioModelCompanion Function({
      Value<int> id,
      Value<String> contenido,
      Value<int> ticketId,
      Value<bool> pendingSync,
    });

final class $$ComentarioModelTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ComentarioModelTable,
          ComentarioModelData
        > {
  $$ComentarioModelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TicketModelTable _ticketIdTable(_$AppDatabase db) =>
      db.ticketModel.createAlias(
        $_aliasNameGenerator(db.comentarioModel.ticketId, db.ticketModel.id),
      );

  $$TicketModelTableProcessedTableManager get ticketId {
    final $_column = $_itemColumn<int>('ticket_id')!;

    final manager = $$TicketModelTableTableManager(
      $_db,
      $_db.ticketModel,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ticketIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ComentarioModelTableFilterComposer
    extends Composer<_$AppDatabase, $ComentarioModelTable> {
  $$ComentarioModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contenido => $composableBuilder(
    column: $table.contenido,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  $$TicketModelTableFilterComposer get ticketId {
    final $$TicketModelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ticketId,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableFilterComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComentarioModelTableOrderingComposer
    extends Composer<_$AppDatabase, $ComentarioModelTable> {
  $$ComentarioModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contenido => $composableBuilder(
    column: $table.contenido,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  $$TicketModelTableOrderingComposer get ticketId {
    final $$TicketModelTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ticketId,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableOrderingComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComentarioModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComentarioModelTable> {
  $$ComentarioModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contenido =>
      $composableBuilder(column: $table.contenido, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  $$TicketModelTableAnnotationComposer get ticketId {
    final $$TicketModelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ticketId,
      referencedTable: $db.ticketModel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TicketModelTableAnnotationComposer(
            $db: $db,
            $table: $db.ticketModel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComentarioModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComentarioModelTable,
          ComentarioModelData,
          $$ComentarioModelTableFilterComposer,
          $$ComentarioModelTableOrderingComposer,
          $$ComentarioModelTableAnnotationComposer,
          $$ComentarioModelTableCreateCompanionBuilder,
          $$ComentarioModelTableUpdateCompanionBuilder,
          (ComentarioModelData, $$ComentarioModelTableReferences),
          ComentarioModelData,
          PrefetchHooks Function({bool ticketId})
        > {
  $$ComentarioModelTableTableManager(
    _$AppDatabase db,
    $ComentarioModelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComentarioModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComentarioModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComentarioModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contenido = const Value.absent(),
                Value<int> ticketId = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
              }) => ComentarioModelCompanion(
                id: id,
                contenido: contenido,
                ticketId: ticketId,
                pendingSync: pendingSync,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contenido,
                required int ticketId,
                Value<bool> pendingSync = const Value.absent(),
              }) => ComentarioModelCompanion.insert(
                id: id,
                contenido: contenido,
                ticketId: ticketId,
                pendingSync: pendingSync,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ComentarioModelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ticketId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ticketId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ticketId,
                                referencedTable:
                                    $$ComentarioModelTableReferences
                                        ._ticketIdTable(db),
                                referencedColumn:
                                    $$ComentarioModelTableReferences
                                        ._ticketIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ComentarioModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComentarioModelTable,
      ComentarioModelData,
      $$ComentarioModelTableFilterComposer,
      $$ComentarioModelTableOrderingComposer,
      $$ComentarioModelTableAnnotationComposer,
      $$ComentarioModelTableCreateCompanionBuilder,
      $$ComentarioModelTableUpdateCompanionBuilder,
      (ComentarioModelData, $$ComentarioModelTableReferences),
      ComentarioModelData,
      PrefetchHooks Function({bool ticketId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuarioModelTableTableManager get usuarioModel =>
      $$UsuarioModelTableTableManager(_db, _db.usuarioModel);
  $$CategoriaModelTableTableManager get categoriaModel =>
      $$CategoriaModelTableTableManager(_db, _db.categoriaModel);
  $$TecnicoModelTableTableManager get tecnicoModel =>
      $$TecnicoModelTableTableManager(_db, _db.tecnicoModel);
  $$TicketModelTableTableManager get ticketModel =>
      $$TicketModelTableTableManager(_db, _db.ticketModel);
  $$ComentarioModelTableTableManager get comentarioModel =>
      $$ComentarioModelTableTableManager(_db, _db.comentarioModel);
}
