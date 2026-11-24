---
title: Ficha de hp-node-01 (HP Z420)
date: 2026-11-24
tags: [hardware, servidor]
---
# Ficha de hp-node-01 (HP Z420)

Fuente: foto de la BIOS (chat del equipo, 15 nov 2026) e inventario de solo lectura por SSH con `herramientas/inventario.sh` (24 nov 2026, 16:33, servidor encendido desde el 17 nov). Lo que dice **no verificado** no se pudo confirmar sin `sudo` o sin abrir el equipo.

| Componente | Valor | Nota |
|---|---|---|
| Modelo | HP Z420 Workstation (SKU LJ449AV) | BIOS J61 v01.14 |
| CPU | Intel Xeon E5-1607 a 3,0 GHz | 4 núcleos, 4 hilos (sin Hyper-Threading), 10 MB de L3; baja a 1,2 GHz en reposo |
| Generación | Sandy Bridge-EP (CPUID 206D7) | `/proc/cpuinfo`: AVX sí, **AVX2 no, F16C no**. Los LLM en CPU van por el camino lento |
| RAM | **16 GB visibles** para el sistema (15 GiB en `free -h`) | 6 módulos DDR3 sin búfer: 4+4 GB (DIMM1 y DIMM3) y 4 de 2 GB (DIMM5 a DIMM8). Ver «La RAM que falta» |
| GPU | NVIDIA Quadro 600 (GF108GL, Fermi) | Confirmado con `lspci`. Usa el driver libre `nouveau`. No sirve para IA (ver abajo) |
| Disco | Seagate ST500DM002 de 500 GB, **mecánico** | LVM: la raíz tiene 100 GB (23 GB usados, 24 %); quedan unos 360 GB del disco sin asignar a ningún volumen |
| Red | Intel 82579LM Gigabit (`eno1`) | IP pública de la USACH por DHCP; no se publica aquí. Desde internet, los puertos 22 y 8080 no respondieron (24 nov) |
| SO | **Ubuntu 26.04.1 LTS**, kernel 7.0.0-30-generic | Actualizaciones automáticas activas (`unattended-upgrades`) |
| Tailscale | `hp-node-01` (MagicDNS), snap 1.102.3 | El snap es el origen del error «tailscaled.service does not exist» ([ADR-0001](../decisiones/0001-sistema-operativo.md)) |
| Fuente | HP 623193-001, 600 W | Repuesto reacondicionado: $49.990 (23 nov) |
| Temperatura | 39 °C la CPU en reposo | Límite alto: 87 °C |

## Software instalado (24 nov)
| Qué | Versión | Cómo está |
|---|---|---|
| Ollama | 0.40.16 | Binario en `/usr/local/bin`, servicio systemd con usuario propio. Escucha **solo en la interfaz de Tailscale** (puerto 11434), por eso `ollama list` sin `OLLAMA_HOST` dice «could not connect» |
| Modelos de Ollama | `qwen3:0.6b`, `qwen3:1.7b`, `qwen3:4b`, `qwen3:4b-instruct-2507-q4_K_M`, `frob/qwen3.5-instruct:4b`, `qwen3-4b-direct` | El último sale de un `Modelfile` en el home: `qwen3:4b` con temperatura 0,6 y contexto de 2048 tokens. Ninguno estaba cargado en memoria |
| Python | 3.14.4 | Del sistema. El código del InMoov usa un entorno virtual propio (Flask 3.1.3, requests 2.34.2) |
| git, pip3 | sí | — |
| ffmpeg, Mosquitto, Piper, Whisper, `llama-server` | no instalados | Hacen falta en las etapas E0 y E1 |
| Docker | no instalado | — |
| Paquetes de NVIDIA 620.70 (solo librerías) | instalados, sin driver cargado | `nvidia-smi` existe pero falla. La serie 620 no soporta Fermi, así que no sirven; se propone quitarlos ([ADR-0004](../decisiones/0004-servidor-llm.md)) |

**Servicios activos** fuera de los del sistema: `ollama`, `ssh`, `snap.tailscale.tailscaled`, `chrony`, `fwupd`, `switcheroo-control`, `unattended-upgrades`, `wpa_supplicant`. Ningún servicio del InMoov corre de forma permanente: el «cerebro» se lanza a mano.

**Puertos escuchando:** 22 (SSH, en todas las interfaces), 11434 (Ollama, solo Tailscale), los puertos internos de Tailscale y el DNS local de systemd. Nada más.

**Seguridad:** `ufw` está activo (sus reglas no se pueden leer sin `sudo`, **no verificado** qué permite). `fail2ban` no corre. El SSH acepta llave y clave. Usuarios con shell: `root` y `railab`; `railab` está en el grupo `sudo` ([ADR-0003](../decisiones/0003-acceso-ssh.md)).

**Código en el servidor:** `~/serverinmoov/` tiene el «cerebro» del InMoov en cinco versiones (`cerebro_inmoov_v3.py` a `v7.py`, del 19 al 21 nov), una carpeta `memoria/` con tres notas `.md` y su entorno virtual. En el home está también `inmoov_cliente_hp.py`, el cliente de voz que corre en `hp-voz-01`. Nada de esto está en git. La revisión está en la [bitácora](../bitacora/2026-11-24-auditoria.md).

## La RAM que falta
La foto de la BIOS del 15 nov muestra 18 GB en 7 módulos, con la ranura 2 vacía. El sistema, encendido desde el 17 nov, ve 6 módulos y marca vacías DIMM2 y DIMM4. Falta entonces un módulo de 2 GB, probablemente el de DIMM4 (**no verificado**): o se sacó entre el 15 y el 17 nov, o la placa no lo reconoce al arrancar. Para saberlo hay que abrir el equipo, mover ese módulo a otra ranura y reiniciar. Además, los módulos tienen velocidades distintas (cinco de 1600 y uno de 1333 MT/s), y por eso la BIOS los hace andar a todos a 1066 MHz.

## Riesgo al arrancar
Ollama está atado a la IP de Tailscale. Si después de un corte de luz Ollama arranca antes que Tailscale, falla, y systemd lo reintenta cada 3 s (`Restart=always`) hasta que la interfaz exista. Debería recuperarse solo, pero no se ha probado con un corte real (**no verificado**). En norea-node, un caso parecido dejó a Ollama caído el 23 nov.

## Los otros dos Z420
Están sin fuente. Con dos fuentes más (unos $100.000 en total) el lab tendría tres nodos iguales, y ahí se decide el clúster ([ADR-0005](../decisiones/0005-orquestacion-cluster.md)). Camilo sugirió que, si los nodos solo llevan CPU y RAM, podría bastar una fuente de menos watts (**no verificado**: el conector de la placa es propio de HP).

## Cómo repetir el inventario
`ssh railab@hp-node-01 'bash -s' < herramientas/inventario.sh` desde la raíz del repo. El script solo lee: no usa `sudo` ni cambia nada. Antes de pegar su salida en un documento público, hay que borrar las IPs.

Relacionado: [ADR-0004](../decisiones/0004-servidor-llm.md) · Up: [documentación](../README.md)
