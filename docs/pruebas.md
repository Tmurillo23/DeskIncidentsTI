# Matriz mínima de pruebas - Mesa de Ayuda TI con SLA

## Información general

**Nombre de la app:** Mesa de Ayuda TI con SLA  
**Tipo de app:** App de gestión de incidentes tecnológicos con asignación a técnicos y control de SLA  
**Plataforma evaluada:** Web / Android  
**Versión evaluada:** 1.0.0+1  
**Fecha de prueba:**  
**Equipo evaluador:** Equipo 2  

---

## Objetivo de la matriz

Esta matriz permite validar si la app cumple condiciones mínimas de calidad antes de considerarse una versión candidata a entrega.

No se busca demostrar que la app es perfecta.  
Se busca evidenciar:

- Qué se probó.
- Qué funcionó.
- Qué falló.
- Qué riesgos quedan abiertos.
- Si la app puede o no considerarse Release Candidate.

---

## Estados posibles

| Estado | Significado |
|---|---|
| Pendiente | El caso todavía no se ha ejecutado |
| Aprobado | El resultado obtenido coincide con el resultado esperado |
| Falló | El resultado obtenido no coincide con el resultado esperado |
| No aplica | El caso no aplica para esta app o plataforma |

---

## Matriz de pruebas

| ID | Categoría | Escenario | Pasos | Resultado esperado | Estado | Evidencia / Observación |
|---|---|---|---|---|---|---|
| CP-01 | Inicio | Abrir la app | Ejecutar la app en web o Android | La app abre sin pantalla blanca ni crash | Pendiente | |
| CP-02 | Build | Verificar versión | Revisar `pubspec.yaml` | La app tiene versión definida, por ejemplo `1.0.0+1` | Pendiente | |
| CP-03 | Datos | Cargar tickets locales | Abrir la pantalla principal con tickets existentes | La app muestra la lista de tickets o estado vacío | Pendiente | |
| CP-04 | UI State | Loading inicial | Abrir la app o simular carga lenta | Se muestra un indicador de carga y la app no parece congelada | Pendiente | |
| CP-05 | UI State | Lista vacía | Ejecutar la app sin tickets registrados | Se muestra un mensaje claro de estado vacío | Pendiente | |
| CP-06 | Funcionalidad | Crear ticket válido | Presionar "Nuevo ticket", ingresar título, seleccionar categoría, asignar prioridad y guardar | El ticket aparece en la lista con estado "Pendiente" | Pendiente | |
| CP-07 | Validación | Crear ticket sin título | Abrir formulario y guardar sin escribir título | La app muestra validación y no guarda el ticket | Pendiente | |
| CP-08 | UI extrema | Crear ticket con texto largo | Ingresar descripción muy larga en el formulario | La tarjeta no genera overflow ni rompe el diseño | Pendiente | |
| CP-09 | Funcionalidad | Completar ticket | Marcar un ticket como "Resuelto" con comentario de solución | El ticket cambia visualmente al estado "Resuelto" | Pendiente | |
| CP-10 | Sincronización | Ver estado sincronizado | Crear un ticket con conexión normal | El ticket queda como "Sincronizado" si Firebase responde correctamente | Pendiente | |
| CP-11 | Sincronización | Error de red | Usar el menú QA: "simular error de red" | La app no crashea y el ticket queda como "Sincronización pendiente" | Pendiente | |
| CP-12 | Permisos | Error permission-denied | Usar el menú QA: "simular permission-denied" | La app no crashea, registra el error y deja el ticket pendiente | Pendiente | |
| CP-13 | Error inesperado | Error remoto inesperado | Usar el menú QA: "simular error inesperado" | La app no se rompe y registra el error en logs | Pendiente | |
| CP-14 | Error de UI | Error desde acción de usuario | Usar el menú QA: "simular error de UI" | La app muestra mensaje controlado y registra el error técnico | Pendiente | |
| CP-15 | Sincronización | Sincronizar pendientes | Presionar "Sincronizar pendientes" | La app intenta reenviar tickets pendientes a Firebase | Pendiente | |
| CP-16 | Remoto | Actualizar desde Firebase | Presionar "Actualizar desde Firebase" | La app intenta traer datos remotos sin romper la UI | Pendiente | |
| CP-17 | Logs | Revisar logs en debug | Ejecutar la app con `flutter run` y probar acciones QA | La terminal muestra logs de info, warning o error según el caso | Pendiente | |
| CP-18 | Usuario | Mensajes amigables | Provocar un error simulado | El usuario ve un mensaje entendible, no un stacktrace | Pendiente | |
| CP-19 | Release Web | Generar build web | Ejecutar `flutter build web --release` | Se genera la carpeta `build/web/` | Pendiente | |
| CP-20 | Release Android | Generar APK release | Ejecutar `flutter build apk --release` | Se genera un `.apk` en `build/app/outputs/flutter-apk/` | Pendiente | |

---

## 6.1 Unit Tests

Cada equipo debe implementar mínimo 6 unit tests. Estos validan principalmente reglas de negocio, reglas de autorización, cambios de estado, validaciones, permisos por rol y comportamiento de sincronización o estado pendingSync.

Los unit tests pueden ubicarse en `test/` o dentro de `test/unit/`.

### Casos de unit test - Mesa de Ayuda TI con SLA

| ID | Nombre del test | Descripción | Regla de negocio validada | Estado | Evidencia / Observación |
|---|---|---|---|---|---|
| UT-01 | `todo_ticket_nuevo_inicia_en_pendiente` | Al crear un ticket nuevo, su estado inicial debe ser `Pendiente` sin importar el rol del creador | Todo ticket nuevo inicia en estado pendiente | Pendiente | |
| UT-02 | `categoria_critica_asigna_prioridad_alta_automaticamente` | Al seleccionar una categoría marcada como crítica, el modelo debe asignar automáticamente prioridad alta | Si la categoría es crítica, la prioridad debe quedar automáticamente en alta | Pendiente | |
| UT-03 | `tecnico_no_puede_cerrar_ticket_sin_comentario_de_solucion` | Intentar cerrar un ticket sin comentario de solución debe lanzar un error de validación o retornar `false` | Un técnico no puede cerrar un ticket sin comentario de solución | Pendiente | |
| UT-04 | `ticket_cerrado_no_puede_editarse` | Intentar modificar los campos de un ticket con estado `Cerrado` debe ser bloqueado por la lógica de negocio | Un ticket cerrado no puede editarse | Pendiente | |
| UT-05 | `ticket_vencido_cuando_supera_tiempo_maximo_de_atencion` | Un ticket cuya fecha de creación supera el tiempo máximo definido en el SLA debe tener estado `Vencido` | Si vence el tiempo máximo de atención, el ticket debe mostrarse como vencido | Pendiente | |
| UT-06 | `solo_administrador_puede_reasignar_ticket` | Un usuario con rol `Técnico` o `Solicitante` no puede reasignar un ticket; solo el rol `Administrador` tiene ese permiso | Solo el administrador puede reasignar un ticket | Pendiente | |
| UT-07 | `solicitante_no_puede_cambiar_estado_de_ticket` | Un usuario con rol `Solicitante` no puede cambiar el estado de un ticket a ningún otro valor | Regla de autorización por rol | Pendiente | |
| UT-08 | `ticket_sin_conexion_queda_como_pendingSync` | Al crear un ticket sin conexión a red, el registro debe persistir localmente con estado `pendingSync` | Registro creado sin conexión queda como pendingSync | Pendiente | |

---

## 6.2 Widget Tests

Cada equipo debe implementar mínimo 4 widget tests. Estos validan componentes visuales y estados de UI.

Los widget tests pueden ubicarse en `test/` o dentro de `test/widget/`.

### Casos de widget test - Mesa de Ayuda TI con SLA

| ID | Nombre del test | Descripción | Estado de UI validado | Estado | Evidencia / Observación |
|---|---|---|---|---|---|
| WT-01 | `formulario_de_crear_ticket_muestra_serial_y_categoria` | Al renderizar `CrearTicketDialog`, deben aparecer los campos "Serial del equipo" y "Categoría" junto con el título "Crear ticket" | El formulario de creación muestra los campos requeridos | Pendiente | |
| WT-02 | `valida_serial_vacio_cuando_se_intenta_crear_el_ticket` | Al presionar "Crear" sin ingresar serial, la UI debe mostrar el mensaje "El serial no puede estar vacío." | La validación de campo obligatorio se muestra correctamente | Pendiente | |
| WT-03 | `asigna_prioridad_alta_al_elegir_una_categoria_critica` | Al seleccionar "Fallas de hardware" en el dropdown, la UI debe mostrar "Prioridad asignada: Alta" automáticamente | La prioridad alta se asigna y muestra al elegir categoría crítica | Pendiente | |
| WT-04 | `valida_categoria_vacia_cuando_se_intenta_crear_el_ticket` | Al ingresar serial pero no seleccionar categoría y presionar "Crear", la UI muestra "Selecciona una categoría." | La validación de categoría obligatoria se muestra correctamente | Pendiente | |
| WT-05 | `renderiza_el_resumen_del_ticket` | Al renderizar `TicketCard`, deben mostrarse el ID, estado, prioridad, serial, técnico, usuario y categoría del ticket | La tarjeta de ticket muestra todos los datos resumen correctamente | Pendiente | |
| WT-06 | `muestra_comnetario_solo_cuando_el_ticket_tiene_uno` | Al renderizar `TicketCard` con comentario, este aparece; al renderizarla sin comentario, no aparece ningún texto de comentario | El comentario en la tarjeta solo se muestra cuando existe | Pendiente | |

---

## 6.3 Model / Serialization Tests

Estos tests validan que los modelos de datos se copian y serializan correctamente hacia y desde Firestore.

Los model tests pueden ubicarse en `test/` o dentro de `test/unit/`.

### Casos de model test - Mesa de Ayuda TI con SLA

| ID | Nombre del test | Descripción | Regla validada | Estado | Evidencia / Observación |
|---|---|---|---|---|---|
| MT-01 | `copyWith_preserves_fields_and_updates_pendingSync` | Al llamar `copyWith` sobre un `Usuario`, los campos no modificados se conservan y solo los campos especificados cambian | `copyWith` no altera campos no especificados | Pendiente | |
| MT-02 | `ticket_round_trips_through_firestore_map` | Un ticket serializado con `toFirestore()` y restaurado con `fromFirestore()` debe conservar todos sus campos y relaciones | La serialización y deserialización hacia Firestore es fiel al modelo original | Pendiente | |

---

## Casos adicionales por dominio

| ID | Categoría | Escenario | Pasos | Resultado esperado | Estado | Evidencia / Observación |
|---|---|---|---|---|---|---|
| CP-D01 | Dominio | Ticket con categoría crítica | Crear un ticket seleccionando una categoría marcada como crítica | La prioridad se asigna automáticamente como "Alta" sin intervención del usuario | Pendiente | |
| CP-D02 | Dominio | Cerrar ticket sin comentario | Intentar cerrar un ticket sin ingresar comentario de solución | La app bloquea la acción y muestra mensaje indicando que el comentario es obligatorio | Pendiente | |
| CP-D03 | Dominio | Doble envío de ticket | Presionar dos veces rápidamente el botón "Guardar" en el formulario de nuevo ticket | La app crea un solo ticket, no duplicados | Pendiente | |
| CP-D04 | Dominio | Reasignación por rol incorrecto | Un usuario con rol Técnico intenta reasignar un ticket desde la UI | La app no permite la acción y muestra mensaje de permiso denegado | Pendiente | |
| CP-D05 | Dominio | Flujo principal completo | Login → crear ticket → seleccionar categoría → asignar prioridad → guardar | El ticket aparece en la lista con estado "Pendiente" | Pendiente | |

---

## Evidencias sugeridas

Para cada caso pueden registrar:

- Captura de pantalla.
- Mensaje mostrado al usuario.
- Fragmento relevante de logs.
- Descripción breve del comportamiento.
- Estado visual del ticket.
- Error observado en terminal o consola.

---

## Resumen de resultados

| Resultado | Cantidad |
|---|---:|
| Casos aprobados | |
| Casos fallidos | |
| Casos pendientes | |
| Casos no aplica | |

---

## Observaciones generales

Escribir aquí observaciones importantes encontradas durante la prueba.

Ejemplo:

- La app funciona correctamente en el flujo principal de creación de tickets.
- Los errores simulados no generan crash.
- El estado pendingSync se muestra correctamente en la tarjeta del ticket.
- La restricción de reasignación por rol funciona correctamente.
- Falta mejorar el indicador visual cuando el SLA vence durante la sesión activa.
- Falta probar en dispositivo físico Android.