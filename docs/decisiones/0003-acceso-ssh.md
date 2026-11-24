---
title: "ADR-0003: acceso por SSH"
date: 2026-11-24
estado: propuesta
tags: [adr, servidor, seguridad]
---
# ADR-0003: acceso por SSH

- **Estado:** propuesta
- **Propone:** Camilo (auditoría del 24 nov 2026)
- **Validado por:** —
- **Evidencia:** intento de SSH del 24 nov (`Permission denied (publickey,password)`); foto del 19 nov (`eno1` tiene una IP pública de la USACH); prueba con `nc` desde internet del 24 nov: los puertos 22 y 8080 no responden. Inventario del 24 nov (tarde), ya con la llave de Camilo agregada: el SSH acepta llave y clave, solo `root` y `railab` tienen shell, `railab` está en `sudo`, `ufw` está activo y `fail2ban` no corre ([ficha](../hardware/hp-node-01.md)).

## Contexto
Todos entran al servidor con un mismo usuario, `railab`, y una clave. Quien no estaba cuando se creó no tiene la clave, y no hay registro de quién hizo qué. La tarjeta de red tiene una IP pública de la USACH, pero desde internet los puertos probados no responden, así que el firewall de la universidad parece bloquear la entrada (**no verificado** para los demás puertos).

## Opciones
| Opción | A favor | En contra |
|---|---|---|
| Usuario compartido con clave (hoy) | Es simple | La clave pasa de mano en mano; no se sabe quién hizo qué; si se filtra, hay que avisarle a todos |
| Un usuario por persona con llave SSH | Cada uno tiene su llave; se saca a una persona sin molestar al resto; queda registro de quién entró | Hay que crear los usuarios y enseñar a generar llaves |
| Tailscale SSH | La identidad sale de la tailnet y no hay que manejar llaves | Requiere cuentas personales ([ADR-0002](0002-red-tailscale.md)) |

## Decisión
- Un usuario por persona, con llave `ed25519`; los administradores van en el grupo `sudo`.
- `railab` queda solo para correr servicios, sin inicio de sesión.
- Cuando todos tengan llave: `PasswordAuthentication no` en `/etc/ssh/sshd_config.d/`.
- Tailscale SSH se evalúa cuando existan cuentas personales.

## Cómo se valida
Cada persona entra con `ssh <usuario>@hp-node-01` sin escribir clave, y `ssh -o PubkeyAuthentication=no` es rechazado.

## Consecuencias
Hace falta una guía corta de «crear tu llave y pedir acceso» ([guías](../guias/README.md)). Antes de desactivar las claves hay que confirmar que al menos dos administradores entran con llave; si no, se pierde el acceso remoto.

Relacionado: [ADR-0002](0002-red-tailscale.md) · [índice](README.md)
