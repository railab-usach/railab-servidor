# Servidor del RAI Lab

Infraestructura de cómputo del **RAI Lab** (Usach Robotics and AI Laboratory, DIMEC, USACH): servidores, red privada y servicios compartidos (mensajería MQTT, modelos de lenguaje, voz) que usan los proyectos del laboratorio. El primer proyecto que la usa es la [cabeza del InMoov](https://github.com/railab-usach/inmoov-cabeza).

> [!NOTE]
> Estado (24 nov 2026): diseño y auditoría. Las decisiones están como «propuesta» hasta validarlas en reunión. Este repo parte del README que escribió Balter Riquelme en `Servidor-RAILAB`.

## Empieza aquí
- [Documentación](docs/README.md)
- [Decisiones (ADR)](docs/decisiones/README.md)
- [Ficha de hp-node-01](docs/hardware/hp-node-01.md)

## Equipos
| Nombre | Qué es | Rol |
|---|---|---|
| `hp-node-01` | HP Z420, Xeon E5-1607, 16 GB visibles (la BIOS mostraba 18), Ubuntu 26.04.1 LTS | Servicios 24/7: MQTT, LLM en CPU, voz |
| `hp-node-02`, `hp-node-03` | HP Z420 sin fuente | Futuro clúster |
| norea-node | Servidor de un integrante, GTX 1060 de 6 GB | GPU compartida por Tailscale cuando una etapa lo pida |

## Versiones
Versiones fijadas y verificadas en PyPI y GitHub el 24 nov 2026. Se actualizan en bloque, con una nota en la bitácora.

| Componente | Versión | Licencia |
|---|---|---|
| Ollama | 0.40.17 | MIT |
| llama.cpp (alternativa) | 1.0.0 | MIT |
| Mosquitto | 2.1.4 (o la del repositorio de Ubuntu) | EPL-2.0 / EDL-1.0 |
| Tailscale | 1.104.7 | BSD-3-Clause |
| uv (entornos de Python) | 0.13.9 | MIT / Apache-2.0 |
| Quartz (publicar los docs, opcional) | 5.2.2 | MIT |

## Licencia
Código bajo [MIT](LICENSE). Documentación bajo CC BY-SA 4.0.
