---
title: "Auditoría de lo hecho del 13 al 23 nov"
date: 2026-11-24
tags: [bitacora, auditoria]
---
# Auditoría de lo hecho del 13 al 23 nov

Hasta hoy, el trabajo del servidor no tenía decisiones escritas ni código en git. Esta auditoría reconstruye lo hecho a partir del chat del equipo y sus fotos, y convierte cada decisión en un ADR para validarla. En la mañana no se pudo revisar el código porque no está en git y no había acceso SSH; en la tarde se entró con llave y se leyó (ver «Actualización»). Todos los ADR siguen como «propuesta» hasta validarlos en reunión.

## Lo que se hizo
- 13 nov: se crea el grupo. Hay un solo Z420 con fuente; se discute Debian vs Ubuntu y un modelo local chico.
- 16 nov: Emilio avanza la visión: detección por color en la Pi, que envía eventos HTTP a un notebook con Ollama.
- 17 nov: Ollama queda en `hp-node-01` y Balter crea la tailnet con una cuenta compartida.
- 18 nov: la Pi queda con cámara y transmisión en `:8080/video_feed`; Balter completa voz→texto→texto→voz en un notebook; nace el repo de Balter.
- 23 nov: Emilio propone un clúster k3s; se cotiza la fuente del Z420.

## Lo que se encontró
- Las cuentas compartidas (Gmail del servidor y GitHub) dependen de una sola clave que conoce todo el grupo.
- El servidor tiene IP pública; desde internet no responde en los puertos probados.
- La CPU no tiene AVX2 y la GPU no sirve para IA.
- Tailscale está instalado como snap, lo que causó el error «tailscaled.service does not exist».
- Los eventos de visión van a una IP escrita a mano que ya no existe en la tailnet.

## Actualización del 24 nov (tarde): inventario y código
Emilio agregó la llave de Camilo y se corrió el inventario de solo lectura. Lo nuevo está en la [ficha de hp-node-01](../hardware/hp-node-01.md):
- Ubuntu 26.04.1 LTS; la GPU es una Quadro 600, como se suponía.
- El sistema ve 16 GB, no 18: falta un módulo de 2 GB que la BIOS mostraba el 15 nov.
- Ollama 0.40.16 escucha solo en Tailscale y tiene seis modelos `qwen3`. Hay librerías de NVIDIA instaladas que no sirven.
- El código del InMoov está en `~/serverinmoov/` (cinco versiones del cerebro, del 19 al 21 nov), sin git. Su revisión está en el [ADR-0007 de inmoov-cabeza](https://github.com/railab-usach/inmoov-cabeza/blob/main/docs/decisiones/0007-voz-y-conversacion.md).

## Decisiones abiertas
Ver el [índice de ADR](../decisiones/README.md). Las del robot están en [inmoov-cabeza](https://github.com/railab-usach/inmoov-cabeza).

Up: [bitácora](README.md)
