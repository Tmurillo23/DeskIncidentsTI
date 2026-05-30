class Usuario {
  final int id;
  final String Nombre;
  final int DocumentoIdentidad;
  final String Correo;
  final String Rol;
  final bool pendingSync;

  Usuario({
    required this.id,
    required this.Nombre,
    required this.DocumentoIdentidad,
    required this.Correo,
    required this.Rol,
    required this.pendingSync,
  });

  Usuario copyWith({
    int? id,
    String? Nombre,
    int? DocumentoIdentidad,
    String? Correo,
    String? Rol,
    bool? pendingSync,
  }) {
    return Usuario(
      id: id ?? this.id,
      Nombre: Nombre ?? this.Nombre,
      DocumentoIdentidad: DocumentoIdentidad ?? this.DocumentoIdentidad,
      Correo: Correo ?? this.Correo,
      Rol: Rol ?? this.Rol,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': Nombre,
      'documentoIdentidad': DocumentoIdentidad,
      'correo': Correo,
      'rol': Rol,
    };
  }

  factory Usuario.fromFirestore(Map<String, dynamic> map, {required int id}) {
    return Usuario(
      id: id,
      Nombre: map['nombre'] as String? ?? '',
      DocumentoIdentidad: map['documentoIdentidad'] as int? ?? 0,
      Correo: map['correo'] as String? ?? '',
      Rol: map['rol'] as String? ?? '',
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }
}

class Categoria {
  final int id;
  final String Nombre;
  final String Descripcion;
  final String TiempoRespuesta;
  final bool pendingSync;

  Categoria({
    required this.id,
    required this.Nombre,
    required this.Descripcion,
    required this.TiempoRespuesta,
    required this.pendingSync,
  });

  Categoria copyWith({
    int? id,
    String? Nombre,
    String? Descripcion,
    String? TiempoRespuesta,
    bool? pendingSync,
  }) {
    return Categoria(
      id: id ?? this.id,
      Nombre: Nombre ?? this.Nombre,
      Descripcion: Descripcion ?? this.Descripcion,
      TiempoRespuesta: TiempoRespuesta ?? this.TiempoRespuesta,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': Nombre,
      'descripcion': Descripcion,
      'tiempoRespuesta': TiempoRespuesta,
    };
  }

  factory Categoria.fromFirestore(Map<String, dynamic> map, {required int id}) {
    return Categoria(
      id: id,
      Nombre: map['nombre'] as String? ?? '',
      Descripcion: map['descripcion'] as String? ?? '',
      TiempoRespuesta: map['tiempoRespuesta'] as String? ?? '',
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }
}

class Tecnico {
  final int id;
  final String Nombre;
  final int DocumentoIdentidad;
  final String Correo;
  final String Password;
  final bool pendingSync;
  final List<Ticket>? tickets;

  Tecnico({
    required this.id,
    required this.Nombre,
    required this.DocumentoIdentidad,
    required this.Correo,
    required this.Password,
    required this.pendingSync,
    this.tickets,
  });

  Tecnico copyWith({
    int? id,
    String? Nombre,
    int? DocumentoIdentidad,
    String? Correo,
    String? Password,
    bool? pendingSync,
    List<Ticket>? tickets,
  }) {
    return Tecnico(
      id: id ?? this.id,
      Nombre: Nombre ?? this.Nombre,
      DocumentoIdentidad: DocumentoIdentidad ?? this.DocumentoIdentidad,
      Correo: Correo ?? this.Correo,
      Password: Password ?? this.Password,
      pendingSync: pendingSync ?? this.pendingSync,
      tickets: tickets ?? this.tickets,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': Nombre,
      'documentoIdentidad': DocumentoIdentidad,
      'correo': Correo,
      'password': Password,
    };
  }

  factory Tecnico.fromFirestore(Map<String, dynamic> map, {required int id}) {
    return Tecnico(
      id: id,
      Nombre: map['nombre'] as String? ?? '',
      DocumentoIdentidad: map['documentoIdentidad'] as int? ?? 0,
      Correo: map['correo'] as String? ?? '',
      Password: map['password'] as String? ?? '',
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }
}

class Comentario {
  final int id;
  final String Contenido;
  final bool pendingSync;

  Comentario({
    required this.id,
    required this.Contenido,
    required this.pendingSync,
  });

  Comentario copyWith({
    int? id,
    String? Contenido,
    bool? pendingSync,
  }) {
    return Comentario(
      id: id ?? this.id,
      Contenido: Contenido ?? this.Contenido,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'contenido': Contenido,
    };
  }

  factory Comentario.fromFirestore(Map<String, dynamic> map, {required int id}) {
    return Comentario(
      id: id,
      Contenido: map['contenido'] as String? ?? '',
      pendingSync: map['pendingSync'] as bool? ?? false,
    );
  }
}

class Ticket {
  final int id;
  final String Estado;
  final DateTime FechaCreacion;
  final String Prioridad;
  final String SerialEquipo;
  final bool pendingSync;

  final Tecnico tecnico;
  final Categoria categoria;
  final Usuario usuario;
  final Comentario comentario;

  Ticket({
    required this.id,
    required this.Estado,
    required this.FechaCreacion,
    required this.Prioridad,
    required this.SerialEquipo,
    required this.pendingSync,
    required this.tecnico,
    required this.categoria,
    required this.usuario,
    required this.comentario,
  });

  Ticket copyWith({
    int? id,
    String? Estado,
    DateTime? FechaCreacion,
    String? Prioridad,
    String? SerialEquipo,
    bool? pendingSync,
    Tecnico? tecnico,
    Categoria? categoria,
    Usuario? usuario,
    Comentario? comentario,
  }) {
    return Ticket(
      id: id ?? this.id,
      Estado: Estado ?? this.Estado,
      FechaCreacion: FechaCreacion ?? this.FechaCreacion,
      Prioridad: Prioridad ?? this.Prioridad,
      SerialEquipo: SerialEquipo ?? this.SerialEquipo,
      pendingSync: pendingSync ?? this.pendingSync,
      tecnico: tecnico ?? this.tecnico,
      categoria: categoria ?? this.categoria,
      usuario: usuario ?? this.usuario,
      comentario: comentario ?? this.comentario,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'estado': Estado,
      'fechaCreacion': FechaCreacion.toIso8601String(),
      'prioridad': Prioridad,
      'serialEquipo': SerialEquipo,
      'pendingSync': pendingSync,
      'tecnicoId': tecnico.id,
      'categoriaId': categoria.id,
      'usuarioId': usuario.id,
      'comentarioId': comentario.id,
    };
  }

  factory Ticket.fromFirestore(Map<String, dynamic> map, {required int id}) {
    return Ticket(
      id: id,
      Estado: map['estado'] as String? ?? '',
      FechaCreacion:
          DateTime.tryParse(map['fechaCreacion'] as String? ?? '') ??
              DateTime.now(),
      Prioridad: map['prioridad'] as String? ?? '',
      SerialEquipo: map['serialEquipo'] as String? ?? '',
      pendingSync: map['pendingSync'] as bool? ?? false,
      tecnico: Tecnico(
        id: map['tecnicoId'] as int? ?? 0,
        Nombre: '',
        DocumentoIdentidad: 0,
        Correo: '',
        Password: '',
        pendingSync: false,
      ),
      categoria: Categoria(
        id: map['categoriaId'] as int? ?? 0,
        Nombre: '',
        Descripcion: '',
        TiempoRespuesta: '',
        pendingSync: false,
      ),
      usuario: Usuario(
        id: map['usuarioId'] as int? ?? 0,
        Nombre: '',
        DocumentoIdentidad: 0,
        Correo: '',
        Rol: '',
        pendingSync: false,
      ),
      comentario: Comentario(
        id: map['comentarioId'] as int? ?? 0,
        Contenido: '',
        pendingSync: false,
      ),
    );
  }
}