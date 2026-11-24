---
title: "ADR-0002: red privada con Tailscale"
date: 2026-11-24
estado: propuesta
tags: [adr, servidor, red, seguridad]
---
# ADR-0002: red privada con Tailscale

- **Estado:** propuesta
- **Propone:** Camilo (auditoría del 24 nov 2026)
- **Validado por:** —
- **Evidencia:** `tailscale status` del 24 nov (10 equipos, todos con la misma cuenta); chat del equipo del 17 nov; [precios de Tailscale, versión 4 (abril 2026)](https://tailscale.com/blog/pricing-v4).

## Contexto
El 17 nov, Balter creó la red Tailscale (*tailnet*) con una cuenta de Gmail del servidor, y todos los equipos entraron con esa misma cuenta. Quien tenga la clave de esa cuenta administra la red completa. No hay reglas de acceso (ACL), así que celulares y PCs personales ven a todos los equipos.

El plan gratuito de Tailscale permite **6 usuarios**, equipos de usuario ilimitados y unos 50 equipos con etiqueta. Solo sirve para uso no comercial, y el lab cumple esa condición.

Medición desde fuera del lab: el ping a `hp-node-01` va por el relay de Miami, con unos 195 ms. Dentro de la sala se espera conexión directa (**no verificado**).

## Opciones
| Opción | A favor | En contra |
|---|---|---|
| Una cuenta compartida (hoy) | Es simple | No hay identidades; quien tenga la clave administra todo; no se puede sacar a una sola persona |
| Cuentas personales (hasta 6) + etiquetas + ACL | Cada uno con su identidad; se puede revocar; las reglas dicen quién llega a qué | El tope de 6 usuarios alcanza solo para el equipo que administra |
| Headscale (servidor de control libre, BSD-3) | Sin límite de usuarios; calza con un lab de código abierto | Necesita un puerto abierto a internet, y el firewall de la USACH lo bloquea; hay que mantenerlo |

## Decisión
- Cuentas personales para quienes administran (6 como máximo).
- Los servidores y robots entran con etiqueta (`tag:servidor`, `tag:robot`), así que no gastan cupos de usuario.
- ACL mínima: los miembros llegan a los puertos de servicio y solo los administradores llegan al 22.
- La cuenta del lab queda como dueña: se le cambia la clave, se le activa la verificación en dos pasos y se revocan los enlaces de invitación vigentes. Las claves se pasan en persona o con un gestor de contraseñas, nunca por chat.
- Los equipos personales externos, como norea-node, entran compartidos (*node sharing*), nunca invitando a gente a otra tailnet.

## Cómo se valida
- `tailscale ping hp-node-01` desde la Pi, dentro de la sala, dice *direct* y no *DERP*.
- La consola de administración muestra 6 usuarios o menos, y todos los servidores con etiqueta.

## Consecuencias
Quien no administra (por ejemplo, un integrante nuevo) usa los servicios por la red del lab o pide que se comparta su equipo. Si el lab crece más allá de 6 administradores, se reevalúa Headscale.

Relacionado: [ADR-0003](0003-acceso-ssh.md) · [índice](README.md)
