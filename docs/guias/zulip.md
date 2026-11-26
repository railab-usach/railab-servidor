---
title: Zulip del lab
date: 2026-11-26
tags: [guia, comunicacion, zulip]
---
# Zulip del lab: cómo se ordena y cómo se pone en marcha

> **En pausa (26 nov 2026):** [ADR-0007](../decisiones/0007-plataforma-de-comunicacion.md) quedó pospuesto hasta que el lab tenga UPS. Esta guía sirve el día que se retome.

## Qué cambia frente a WhatsApp
En WhatsApp todo cae en un solo hilo: la llave de la sala, la RAM del servidor, la IA que se usa y los stickers. En Zulip cada mensaje va a un **canal** (el área) y a un **tema** (la conversación puntual). Se lee solo lo que te toca y cada tema queda como un registro que se puede enlazar desde un issue o un ADR.

## Canales
Salen de lo que se habló en el grupo del servidor entre el 18 y el 26 de noviembre de 2026.

| Canal | Para qué | Temas típicos |
|---|---|---|
| `general` | Avisos del lab y reuniones | «Reunión validación ADR», «Presupuesto 2026» |
| `sala` | Lo práctico del espacio físico | «Llave y horarios de la sala», «Impresoras 3D», «Materiales que faltan» |
| `servidor` | Infraestructura compartida | «hp-node-01 hardware», «Tailscale», «Accesos y cuentas» |
| `inmoov` | Proyecto InMoov | Un tema por reto con el código del issue: «E0-4 medir LLM», «E1-2 calibrar servos» |
| `pendulo` | Proyecto péndulo PID | Uno por reto o ensayo |
| `balancin` | Robot balancín seguidor | Uno por reto |
| `github` | Avisos automáticos de commits, PR y CI | Un tema por repo (lo crea la integración) |
| `difusion` | Lo que se publica en Instagram | Uno por publicación |

Proyecto nuevo, canal nuevo. Las conversaciones sueltas van a `general` con un tema que diga de qué se trata.

## Reglas
1. Nada de claves, IPs ni datos personales en ningún canal.
2. Las decisiones se proponen en un ADR o en un issue; el chat solo las discute y enlaza.
3. El tema lleva un nombre que se entienda en seis meses: «E0-4 medir LLM», no «oe».
4. WhatsApp queda solo para urgencias durante el primer mes.

## Puesta en marcha (una tarde)
1. Crear la organización en Zulip Cloud con el correo del lab, con URL `railab-usach.zulipchat.com` si está libre.
2. Pedir el patrocinio Standard como proyecto de código abierto universitario, enlazando los repos públicos de `railab-usach`. Si no lo aprueban, el plan Free alcanza para empezar.
3. Crear los canales de arriba e invitar por correo a los integrantes, cada uno con su cuenta.
4. Conectar la integración de GitHub: cada repo publica en `github`, con un tema por repo.
5. Crear un bot de solo lectura para Claude, suscrito solo a los canales que el grupo apruebe. Su llave se guarda fuera de los repos.
6. Fijar en `general` un mensaje con estas reglas y el enlace a esta guía.

## Cómo se valida
Lo mismo que el ADR: en dos semanas todos escribieron en su canal; el bot resume un tema con enlaces fieles; al mes no hay conversaciones de trabajo en WhatsApp.

Up: [guías](README.md)
