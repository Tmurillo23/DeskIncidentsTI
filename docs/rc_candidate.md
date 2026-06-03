# Declaración de Release Candidate - TaskSync RC

## Información general

**Nombre de la app:** TaskSync RC  
**Versión evaluada:** 1.0.0+1  
**Plataforma evaluada:** Web / Android  
**Fecha de evaluación: **  
**Equipo evaluador: Tatiana Murillo Mosquera**  

---

## ¿Qué es una Release Candidate?


---

## Criterios mínimos para declarar RC

| Criterio | Estado | Observación |
|---|---|---|
| La app abre sin crash | Aprobado | |
| La versión está definida en `pubspec.yaml` | Aprobado | |
| El flujo principal funciona | Aprobado | |
| La app permite crear tareas válidas | Aprobado | |
| La app valida tareas sin título | Aprobado | |
| La app muestra estado Loading | Pendiente | |
| La app muestra estado Empty | Aprobado | |
| La app muestra estado Data | Aprobado | |
| La app maneja errores sin mostrar stacktrace al usuario | Aprobado | |
| La app maneja fallos remotos sin perder datos locales | Aprobado | |
| La app muestra tareas pendientes de sincronización | Pendiente | |
| La matriz mínima de pruebas fue ejecutada | Aprobado | |
| No hay bugs P1 abiertos | Aprobado | |
| Los bugs P2 y P3 están documentados | Aprobado | |
| El README o instrucciones de ejecución están actualizados | Aprobado | |

---

## Resultado de la evaluación

Marcar una opción:

- [X] Esta build ES candidata a RC-1.
- [ ] Esta build NO ES candidata a RC-1 todavía.

---

## Justificación


La build `1.0.0+1` puede considerarse RC-1 porque el flujo principal de tickets funciona, la app abre correctamente, permite crear y completar tickets, asigna técnicos y agregar comentarios a los roles que pueden hacerlo,maneja errores simulados sin crashear y no tiene bugs P1 abiertos. Los bugs menores encontrados quedaron documentados en el backlog.

---

## Bugs encontrados

| ID | Título | Pasos para reproducir | Prioridad | Estado |
|---|---|---|---|---|
| BUG-01 | Texto largo puede generar overflow visual | 1. Crear ticket con título de 30 carácteres| P2 | Mínimo |
| BUG-02 | Falta mejorar el estado de carga al iniciar la app | 1. Abrir app  | P2 | Mínimo |

---


---

## Riesgos conocidos


- Falta probar en dispositivo físico.
- Falta probar con red inestable real.
- Falta configurar Crashlytics para Android.
- El estado offline solo se evidencia como sincronización pendiente.




## Declaración final

Completar una de las siguientes frases:

### Si es RC

La build ` app-debug.apk ` puede considerarse **RC-1** porque:

Cumple con los requitiso básico estipulados para su lanzamiento



---

## Próximos pasos

- Mejorar mensajes de error.
- Probar en Android físico.
- Generar APK release.
- Completar casos pendientes de la matriz.
- Actualizar README.
