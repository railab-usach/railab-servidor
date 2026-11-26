---
title: Decisiones del servidor (ADR)
date: 2026-11-24
tags: [indice, adr]
---
# Decisiones del servidor (ADR)

Cada decisión de arquitectura queda en un archivo numerado. La regla: **nada se mantiene porque ya estaba hecho**. Lo que existe también pasa por un ADR para validarlo. Un ADR pasa de «propuesta» a «aceptada» en una reunión, anotando quiénes estuvieron y la fecha.

| ADR | Qué se propone | Estado |
|---|---|---|
| [0001](0001-sistema-operativo.md) | Mantener Ubuntu Server LTS; servicios por `apt`, no snap | propuesta |
| [0002](0002-red-tailscale.md) | Tailscale con cuentas personales (6 como máximo), etiquetas y ACL | propuesta |
| [0003](0003-acceso-ssh.md) | Un usuario y una llave SSH por persona; sin claves compartidas | propuesta |
| [0004](0004-servidor-llm.md) | Ollama sin modo «thinking», API estándar y modelo elegido por medición | propuesta |
| [0005](0005-orquestacion-cluster.md) | systemd + `uv` ahora; el clúster se decide midiendo cuando haya 2 nodos | propuesta |
| [0006](0006-repositorios-y-licencia.md) | Dos repos públicos con docs en Obsidian; MIT y CC BY-SA 4.0 | propuesta |
| [0007](0007-plataforma-de-comunicacion.md) | Zulip Cloud en vez de WhatsApp, con patrocinio gratis y un bot de lectura para Claude | aceptada (26 nov) |

## Cómo proponer una decisión
1. Copia la [plantilla](0000-plantilla.md) con el número siguiente.
2. Llena las opciones con lo que pesa a favor y en contra de cada una, y di cómo se valida.
3. Ábrelo como *pull request* o tráelo a la reunión. Si se acepta, cambia el estado y anota quiénes lo validaron.

Up: [documentación](../README.md)
