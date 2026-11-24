---
title: "ADR-0001: sistema operativo del servidor"
date: 2026-11-24
estado: propuesta
tags: [adr, servidor, so]
---
# ADR-0001: sistema operativo del servidor

- **Estado:** propuesta
- **Propone:** Camilo (auditoría del 24 nov 2026)
- **Validado por:** —
- **Evidencia:** fotos del chat del equipo (17 y 19 nov): el mensaje de bienvenida de `hp-node-01` es de Ubuntu (enlaza a ubuntu.com/pro) y Tailscale quedó instalado como *snap*. Inventario por SSH del 24 nov: **Ubuntu 26.04.1 LTS**, kernel 7.0.0-30, Tailscale snap 1.102.3 ([ficha](../hardware/hp-node-01.md)).

## Contexto
`hp-node-01` es un HP Z420 con 18 GB de RAM ([ficha](../hardware/hp-node-01.md)). El 13 nov, Emilio propuso dejar Debian como base y usar Ubuntu solo dentro de contenedores para ROS, por estabilidad y menor consumo de RAM. Camilo pidió probar ambas opciones. Nadie midió nada y el servidor quedó con Ubuntu Server.

En la foto del 17 nov, `systemctl enable --now tailscaled` falló con «Unit tailscaled.service does not exist» porque Tailscale estaba instalado como snap, y el servicio de un snap se llama distinto. Es una confusión típica de los snaps.

## Opciones
| Opción | A favor | En contra |
|---|---|---|
| Ubuntu Server LTS (lo instalado) | ROS 2 publica paquetes oficiales para Ubuntu LTS; ya funciona; hay mucha documentación en español | Trae snaps por defecto, y sus servicios confunden |
| Debian 13 + contenedores | Base más chica y estable | Hay que reinstalar; ROS 2 en Debian tiene menos soporte; la diferencia de RAM son cientos de MB sobre 18 GB, menos del 3 % (**no verificado**) |
| Proxmox VE | Una máquina virtual por grupo; base para el clúster | Agrega una capa entera para un solo nodo; más difícil para quien recién llega |

## Decisión
Mantener **Ubuntu Server LTS** e instalar los servicios desde `apt` (Tailscale desde su repositorio oficial), no como snaps. Proxmox se evalúa en [ADR-0005](0005-orquestacion-cluster.md), cuando haya tres nodos.

## Cómo se valida
1. `lsb_release -a` confirma la versión LTS.
2. `free -m`, 10 minutos después de arrancar y sin carga, muestra el consumo base. Si Ubuntu gastara más de 1 GB, se reabre la comparación con Debian.

**Primera lectura (24 nov):** el paso 1 se cumple (26.04.1 LTS). Para el paso 2 solo hay una lectura con 6 días encendido y Ollama sin modelos cargados: 758 MiB en uso. No es la medición pedida (10 minutos tras arrancar), pero queda bajo 1 GB.

## Consecuencias
- Desinstalar el snap de Tailscale e instalarlo por `apt`, sin perder la identidad del nodo (hay que anotar cómo se hace en la guía).
- Toda instalación queda escrita en [la guía de instalación](../guias/README.md), para que el servidor se pueda rearmar desde cero.

Relacionado: [ADR-0005](0005-orquestacion-cluster.md) · [ficha de hp-node-01](../hardware/hp-node-01.md) · [índice](README.md)
