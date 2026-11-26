---
title: Cómo trabajamos en el RAI Lab
date: 2026-11-26
tags: [metodologia, participacion, aprendizaje, ferias]
nivel: publico
---
# Cómo trabajamos en el RAI Lab

> **Estado: borrador para discutir con Vicente y el equipo.** Lo escribió un estudiante, no un profesor. Las ideas se contrastaron con la literatura de la sección 8, pero no se han probado en el lab.

El RAI Lab lo mueven sus propios estudiantes. No hay notas ni sueldo, así que lo que más escasea no es la plata ni las herramientas: es la **motivación**. Este documento ordena el trabajo para que cada integrante, sepa lo que sepa, termine algo que funciona, se vea y pueda mostrar con orgullo.

## 1. Filosofía
1. **Andamiaje.** Quien coordina un proyecto deja hecho el esqueleto: la arquitectura, los ADR, las especificaciones, las pruebas automáticas y los diagramas. Los demás construyen piezas dentro de ese esqueleto. Así nadie parte de una hoja en blanco y nadie rompe lo de otro.
2. **Cada uno es dueño de algo.** Se elige un componente y uno se «casa» con él hasta terminarlo. Lleva su nombre en el README del proyecto y es quien lo explica en las ferias.
3. **Primero se planea, después se construye.** Ninguna pieza parte sin especificación y sin saber cómo se comprueba que está lista ([plan de trabajo](https://github.com/railab-usach/inmoov-cabeza/blob/main/docs/plan-de-trabajo.md)).
4. **Victorias cortas.** Una tarea del lab dura una tarde, no un semestre. Cada tarea termina con algo que se ve: una foto, una medición, un servo que se mueve.
5. **Las mejores herramientas gratis.** Antes de usar algo, se compara con las alternativas y se anota la elección en un ADR. Que algo ya esté hecho no basta para mantenerlo.
6. **Si no está escrito, no existe.** Lo que se aprende va a la bitácora del repo, para quien llegue después y para que el InMoov lo pueda contar (sección 6).

7. **El andamio se retira.** Si quien coordina diseña todo para siempre, los demás solo arman y nunca aprenden a decidir. Cada vez que alguien termina una pieza, la siguiente le deja más decisiones a él: primero sigue una especificación, después la completa y al final escribe su propio ADR.
8. **Nadie trabaja solo.** Se trabaja en parejas, y quien ya hizo una misión acompaña a quien la hace por primera vez. Sentirse parte del grupo motiva más que la tarea en sí.

## 2. Tres niveles de participación
Uno parte donde se sienta cómodo y sube cuando quiere. Nadie queda fuera por saber poco.

| Nivel | Qué haces | Qué recibes hecho | Ejemplo | Lo que aprendes |
|---|---|---|---|---|
| **1 · Misión de lab** ★ | Vas al lab y sigues una guía paso a paso: montar, conectar, verificar y dejar una foto | Diagrama, lista de materiales, pasos y cómo verificar | Montar el bus de servos ([misión M-01](https://github.com/railab-usach/inmoov-cabeza/blob/main/docs/misiones/M-01-bus-de-servos.md)) | Electrónica práctica, seguridad, orden |
| **2 · Prueba** ★★ | Corres un script que ya existe, mides y llenas una tabla | Script, tabla vacía y criterio de éxito | Medir 8 modelos de lenguaje en el servidor (E0-4) | Medir con método, Linux, comparar opciones |
| **3 · Componente** ★★★ | Programas una pieza dentro de bordes ya definidos | Especificación, interfaz (mensajes de entrada y salida), pruebas que debe pasar y CI | Firmware que recibe poses por serial y mueve 20 servos (E1-1) | Diseño, programación, trabajo con pruebas |

Dentro de su componente, el dueño decide cómo hacerlo: la especificación fija **qué** debe cumplir, no **cómo**. Cuando termina, ya tiene lista la siguiente tarea para elegir (la gente suele irse justo después de su primer aporte si no ve qué sigue), y escribe en la bitácora qué decidió y por qué (reflexión).

Un componente está **terminado** cuando pasa sus pruebas, el CI está en verde, tiene su página en la documentación y su dueño lo puede explicar en dos minutos.

## 3. Cómo se arma una misión de lab
Las misiones las escribe quien coordina, con la [plantilla](https://github.com/railab-usach/inmoov-cabeza/blob/main/docs/misiones/README.md). Cada una trae:
- **Objetivo** en una frase y **por qué importa** para el proyecto.
- **Materiales** con su ubicación en el lab.
- **Diagrama** de conexiones.
- **Pasos** numerados, uno por acción.
- **Verificación:** cómo saber que quedó bien, con un comando o una medición, no «se ve bien».
- **Qué hacer si falla**, y cuándo detenerse y avisar.
- **Seguridad:** qué no tocar con la fuente enchufada.
- **Entrega:** la foto o el dato que se sube como comentario al issue de esa misión.

## 4. Para nuestro tamaño (2026)
Hoy el InMoov y el servidor los trabajan **dos personas que aprenden** (Emilio y Balter), **una que coordina** (Camilo) y el encargado del lab (Vicente). Con un equipo así, lo que funciona es esto:

| Pieza | Qué es | Por qué para nosotros |
|---|---|---|
| **Aprendizaje cognitivo** como base | Camilo hace la primera vez y explica por qué, después lo hacen juntos y al final solos | Hay una gran diferencia de experiencia; con dos aprendices se puede acompañar a cada uno |
| **Trabajo en pareja** | Emilio y Balter hacen misiones juntos: uno maneja (teclado o cautín) y el otro guía y revisa, y se turnan. Al principio maneja quien sabe menos | Balter recién parte con git y Emilio ya trabajó con ESP32 y PCA9685; así Emilio afianza enseñando y Balter no queda solo |
| **Tablero kanban** en GitHub Projects | Cuatro columnas: por hacer, en curso, en revisión y listo, con **una tarea en curso por persona** | Es gratis y está junto al código; la regla de una tarea evita dejar diez cosas a medias |
| **Revisión de 15 minutos** cada semana | Qué terminé, qué me traba y qué tomo ahora | Mantiene el ritmo sin quitar tiempo; en un lab voluntario, más reuniones desaniman |
| **Demo interna al mes** | Cada uno muestra lo que hizo a Vicente y al grupo | Hace visible el avance y sirve de ensayo para las ferias |

**Lo que no usamos y por qué:** Scrum pide roles fijos, sprints y varias reuniones por ciclo, y está pensado para equipos de 5 a 9 personas con jornada completa. VIP funciona con profesores y créditos de ramo, que el lab no tiene, aunque se toma de él que los antiguos guíen a los nuevos.

## 5. Ritmo
- **Coordinación:** el grupo de WhatsApp para avisos y un issue de GitHub por misión o reto, donde queda la discusión técnica. Zulip quedó en pausa hasta tener UPS ([guía](guias/zulip.md)).
- **Reunión corta** cada dos semanas por Discord, de 20 minutos: qué se terminó, qué se traba y qué misiones hay disponibles. No es para rendir cuentas.
- **Reconocimiento:** cada cosa terminada se anuncia en el grupo con el nombre de quien la hizo y queda en la bitácora y en el README. Lo que se puede mostrar va a Instagram.

## 6. Ferias y demostraciones
Cada proyecto tiene un **kit de demo** en `docs/demo/`, y cualquiera del equipo lo puede presentar:
- **Explicación de 30 segundos** para alguien que no sabe nada: qué hace y por qué es interesante.
- **Explicación técnica de 3 minutos:** cómo funciona por dentro, con el diagrama.
- **Preguntas frecuentes** con respuestas cortas.
- **Lista de montaje** de la demo: qué llevar, cómo armarlo y cómo probarlo antes de que llegue la gente.
- **Plan B** si algo falla en vivo (un video corto del proyecto funcionando).

Un proyecto **va a feria** solo cuando su demo funciona tres veces seguidas sin tocar nada y al menos dos personas del equipo la saben explicar.

## 7. El baúl de cada proyecto (lo que el InMoov lee)
La meta es que el InMoov responda preguntas sobre los proyectos del lab, tanto a un visitante como a alguien técnico. Para eso lee la documentación de los repos. Cada repo usa la misma estructura:

| Archivo | Para quién | Qué tiene |
|---|---|---|
| `README.md` | Todos | Qué es, en un párrafo, y quiénes participan |
| `docs/explicacion-simple.md` | Visitantes | El proyecto sin jerga, con analogías |
| `docs/demo/` | Quien presenta | El kit de demo de la sección 5 |
| `docs/preguntas-frecuentes.md` | Visitantes y técnicos | Preguntas reales que hicieron en ferias |
| `docs/decisiones/` | Técnicos | Los ADR: qué se eligió y por qué |
| `docs/bitacora/` | Técnicos | Lo medido y aprendido, con fecha |

Cada archivo lleva en su encabezado `nivel: publico` o `nivel: tecnico`, para que el InMoov elija cómo responder según quién pregunta. Nunca van claves, IPs ni datos personales: todo lo que esté en el baúl puede terminar dicho en voz alta en una feria.

## 8. En qué se basa
| Idea de este documento | De dónde viene | Qué ajustó |
|---|---|---|
| Andamiaje y niveles | *Aprendizaje cognitivo* (Collins, Brown y Newman, 1989): modelar, guiar, andamiar y **retirar el andamio**, más articular y reflexionar | Se agregó el principio 7 (retirar el andamio) y la reflexión en la bitácora; una revisión de 2024 nota que en STEM suele faltar justamente eso ([SIGCSE](https://par.nsf.gov//servlets/purl/10491208)) |
| Partir por tareas periféricas reales | *Participación periférica legítima* (Lave y Wenger, 1991), estudiada en comunidades de software libre ([Gasson y Purcell](https://core.ac.uk/download/301374706.pdf)) | Las misiones son trabajo real del proyecto, no ejercicios |
| Primera tarea y la siguiente | Estudios de recién llegados al software libre: muchos se van por barreras al entrar o justo tras su primer aporte; la primera tarea debe enganchar, no solo ser fácil ([Steinmacher et al.](https://www.ime.usp.br/~gerosa/papers/IST_SysReview_PrePrint.pdf), [Hao et al. 2026](https://arxiv.org/abs/2603.27136v1)) | Siguiente tarea lista al terminar; documentación clara para elegir |
| Motivación | *Teoría de la autodeterminación*: autonomía, competencia y pertenencia. En robótica, la autonomía y la competencia percibidas predicen la motivación ([Huang, NCSU](https://repository.lib.ncsu.edu/server/api/core/bitstreams/700306c1-fc7a-4fdb-abef-6542c2e92613/content)); en ingeniería, la pertenencia pesó más ([estudio con makerspaces](https://par.nsf.gov//servlets/purl/10356950)) | El dueño decide el *cómo*; trabajo en parejas (principio 8) |
| Equipos que duran años | *Vertically Integrated Projects* (Purdue y otras): equipos de varios años, los antiguos guían a los nuevos y asumen el liderazgo al irse los mayores ([Memphis](https://par.nsf.gov//servlets/purl/10464438)) | Quien ya hizo una misión acompaña al siguiente; pensar en quién sigue cuando Vicente o Camilo egresen |

La evidencia viene casi toda de universidades de EE. UU. y de estudios sin grupo de control: sirve de guía, no de garantía.

Up: [documentación](README.md)
