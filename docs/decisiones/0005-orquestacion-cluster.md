---
title: "ADR-0005: cómo se corren los servicios (y el clúster futuro)"
date: 2026-11-24
estado: propuesta
tags: [adr, servidor, cluster]
---
# ADR-0005: cómo se corren los servicios (y el clúster futuro)

- **Estado:** propuesta
- **Propone:** Camilo (auditoría del 24 nov 2026)
- **Validado por:** —
- **Evidencia:** diagrama k3s de Emilio (chat del equipo, 23 nov); mensajes de Camilo del 13 y 23 nov (Docker Swarm, Ray, Proxmox); cotización de la fuente HP 623193-001 de 600 W a $49.990 reacondicionada (23 nov).

## Contexto
Hay tres HP Z420, pero solo uno tiene fuente. El diagrama de Emilio propone k3s con espacios por grupo, JupyterHub, un servicio de Git, monitoreo y NFS. Camilo propuso Docker Swarm y Proxmox. La afirmación «Swarm gasta la mitad de RAM que k3s» la dio una IA y nadie la midió. Con un solo nodo, ningún orquestador de clúster aporta: no hay a quién repartirle trabajo.

## Opciones
| Opción | A favor | En contra |
|---|---|---|
| systemd + entornos `uv` con versiones fijas | Lo que ya trae Linux; fácil de entender y depurar; cero capas extra | Cada servicio se instala a mano (lo cubre un script del repo) |
| Docker Compose en un nodo | Reproducible; aislado; estándar de la industria | Otra herramienta que aprender ahora |
| Docker Swarm | Viene incluido en Docker; es simple | Su desarrollo está casi detenido (**no verificado**) |
| k3s | Kubernetes liviano; lo que se aprende sirve afuera | Curva alta; su plano de control consume RAM fija |
| Proxmox VE | Máquinas virtuales por grupo; respaldos | Otra capa completa; tiene sentido con varios nodos |

## Decisión
- **Ahora (1 nodo):** systemd + `uv`. Cada servicio tiene su archivo `.service` en el repo y un script de instalación, así el servidor se puede rearmar desde cero sin Docker.
- **Con 2 nodos o más:** se mide en el mismo equipo la RAM ociosa de k3s y de Swarm y se decide en un ADR nuevo. Proxmox entra solo si se necesitan máquinas virtuales por grupo.

## Cómo se valida
Con 2 nodos: `free -m` tras 10 minutos con cada orquestador instalado y sin cargas. Se anotan los números en la bitácora.

## Consecuencias
El diagrama de Emilio queda como visión a un año y se guarda en [bitácora](../bitacora/README.md). Comprar las dos fuentes es el paso que lo destraba.

Relacionado: [ADR-0001](0001-sistema-operativo.md) · [índice](README.md)
