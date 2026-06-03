# DeskTi — Mesa de Ayuda TI con SLA

> Aplicación móvil desarrollada en **Flutter** para la gestión de incidentes tecnológicos con control de tiempos máximos de atención (SLA). Permite registrar tickets, asignarlos a técnicos y controlar su ciclo de vida completo desde la apertura hasta el cierre o vencimiento.

---

## Integrantes del Equipo

Tatiana Murillo Mosquera

Ana María alucema Fernandez

Sebastián Tamayo Avedaño

> **Equipo 2 — Proyecto Final · Desarrollo Móvil**

---

## Descripción del Problema

Las organizaciones enfrentan dificultades para gestionar de manera eficiente los incidentes tecnológicos reportados por sus usuarios. La falta de un sistema centralizado genera pérdida de solicitudes, demoras en la atención y ausencia de control sobre los tiempos de respuesta comprometidos (SLA).

**DeskTi** resuelve esto permitiendo:
- Registrar incidentes con categoría y prioridad.
- Asignar técnicos responsables.
- Monitorear el estado en tiempo real.
- Detectar automáticamente tickets que superan el tiempo máximo de atención (**vencidos**).

---

##  Roles Implementados

| Rol | Descripción |
|-----|-------------|
| **Solicitante** | Crea tickets, consultar su estado. |
| **Técnico** | Gestiona los tickets asignados, actualiza estados y registra la solución. |
| **Administrador** | Administra usuarios, técnicos y puede reasignar tickets. |

---

## Usuarios de Prueba

| Correo | Contraseña | Rol |
|--------|-----------|-----|
| `admin@gmail.com` | `123456` | Administrador |
| `tecnico1@gmail.com` | `123456` | Técnico |
| `usuario1@gmail.com` | `contrasena` | Solicitante |

---

## Entidades Principales

| Entidad | Descripción |
|---------|-------------|
| **Usuario** | Persona que reporta incidentes. Tiene nombre, documento, correo y rol. |
| **Técnico** | Especialista asignado a resolver tickets. Cuenta con credenciales de acceso. |
| **Categoría** | Clasificación del incidente (ej: Hardware, Red, Software). Incluye tiempo de respuesta SLA. |
| **Ticket** | Incidente registrado. Relaciona usuario, técnico y categoría. Tiene estado, prioridad y fecha de creación. |
| **Comentario** | Observación o solución adjunta a un ticket. |


---

##  Modelo en Firestore

La base de datos en **Cloud Firestore** está organizada en 5 colecciones planas en la raíz del proyecto:

```
firestore/
├── users/          → Documentos de usuarios (solicitantes)
├── technicians/    → Documentos de técnicos
├── categories/     → Categorías con tiempoRespuesta (SLA)
├── tickets/        → Tickets con referencias a usuario, técnico y categoría
└── comments/       → Comentarios vinculados a un ticketId
```


> La sincronización offline-first se maneja con el campo `pendingSync: true/false` en cada entidad.

---

##  Reglas de Negocio

1. **Todo ticket nuevo** inicia en estado `pendiente`.
2. Si la **categoría es crítica**, la prioridad debe quedar automáticamente en `alta`.
3. Un **técnico no puede cerrar** un ticket sin registrar un comentario de solución.
4. Un **ticket cerrado no puede editarse**.
5. Si **vence el tiempo máximo** de atención (SLA), el ticket debe mostrarse como `vencido`.
6. **Solo el administrador** puede reasignar un ticket a otro técnico.

---



| Estado | Descripción |
|--------|-------------|
| `pendiente` | Ticket creado, sin técnico asignado. |
| `asignado` | Técnico designado, aún no ha iniciado atención. |
| `cerrado` | Confirmado y finalizado. No editable. |
| `vencido` | El tiempo SLA fue superado sin resolución. |

---

## Flujo Principal

```
[Solicitante]
     │
     ▼
  Login
     │
     ▼
  Crear Ticket
     │  → seleccionar Categoría
     │  → ingresar Serial del Equipo
     │  → Guardar
     │
     ▼
  Estado: PENDIENTE
     │
     ▼  [Administrador asigna técnico]
  Estado: ASIGNADO
     ├──────────────────────────────┐
     ▼                              ▼
  [Técnico agrega          [Tiempo SLA vencido]
   comentario + resuelve]
     │                              │
     ▼                              ▼
  Estado: Cerrado           Estado: VENCIDO

```

---

## Autenticación

La autenticación se realiza mediante **Firebase Authentication** con correo y contraseña:

- La sesión persiste localmente gracias a Firebase Auth.
- El **rol** controla el acceso a las pantallas y funcionalidades disponibles.
- Los técnicos se autentican con sus propias credenciales y solo ven los tickets asignados a ellos.

---

##  Roles y Permisos

| Acción | Solicitante | Técnico | Administrador |
|--------|:-----------:|:-------:|:-------------:|
| Crear ticket | ✅ | ❌ | ❌ |
| Ver mis tickets | ✅ | ❌ | ❌  |
| Ver todos los tickets | ❌ | ❌ | ✅ |
| Cambiar estado de ticket | ❌ | ✅ | ❌ |
| Agregar comentario |❌ | ✅ | ❌ |
| Cerrar ticket | ❌ | ✅ | ❌ |
| Reasignar técnico | ❌ | ❌ | ✅ |


---

##  Persistencia Local

La app usa **Drift** (SQLite) para operaciones **offline-first**:

- Todas las entidades (usuarios, tickets, técnicos, categorías, comentarios) se almacenan localmente en una base de datos SQLite llamada `tickets_app_db`.
- Cada registro tiene el campo `pendingSync` que indica si aún no ha sido sincronizado con Firebase.
- La app funciona **completamente sin conexión** para lectura y escritura local.
- Al recuperar conectividad, la sincronización se ejecuta automáticamente.

### Tablas locales

| Tabla | Campos principales |
|-------|--------------------|
| `UsuarioModel` | id, nombre, documentoIdentidad, correo, rol, pendingSync |
| `TecnicoModel` | id, nombre, documentoIdentidad, correo, password, pendingSync |
| `CategoriaModel` | id, nombre, descripcion, pendingSync |
| `TicketModel` | id, estado, fechaCreacion, prioridad, serialEquipo, tecnicoId, categoriaId, usuarioId, pendingSync |
| `ComentarioModel` | id, contenido, ticketId, pendingSync |

---

## Sincronización con Firebase

La sincronización sigue el patrón **offline-first con cola de pendientes**:

1. El usuario realiza una acción (crear/editar ticket, comentario, etc.).
2. El cambio se guarda **primero en SQLite local** con `pendingSync = true`.
3. La app detecta conectividad y **envía los cambios pendientes a Firestore**.
4. Al confirmar el envío exitoso, se actualiza `pendingSync = false` en local.
5. Para datos remotos nuevos, se usa `insertOnConflictUpdate` (upsert) para evitar duplicados.

```
[Acción del usuario]
        │
        ▼
  SQLite local  ──── sin internet ────→  (espera)
        │                                    │
        │ con internet                       │ al reconectar
        ▼                                    ▼
  Firestore ←──────────────────────── Sync automática
        │
        ▼
  pendingSync = false
```

---

## Instrucciones para Ejecutar el Proyecto

### Prerrequisitos

- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`
- Android Studio o VS Code con extensión Flutter
- Cuenta de Firebase configurada

### Pasos

```bash
# 1. Clonar el repositorio

cd deskti

# 2. Instalar dependencias
flutter pub get

# 3. Generar código de Drift (base de datos local)
dart run build_runner build --delete-conflicting-outputs

# 4. Verificar dispositivos disponibles
flutter devices

# 5. Ejecutar la app
flutter run
```

### Variables de entorno / Firebase

Asegúrate de tener el archivo `google-services.json` (Android) en:
```
android/app/google-services.json
```

---

## APK


Los apks (web y android) fue generado correctamente.

---

