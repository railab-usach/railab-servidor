---
title: "ADR-0008: configuración de la organización en GitHub"
date: 2026-11-26
estado: aceptada
tags: [adr, github, seguridad, proceso]
---
# ADR-0008: configuración de la organización en GitHub

- **Estado:** aceptada (26 nov 2026, Camilo)
- **Propone:** Camilo · **Validado por:** Camilo, coordinador
- **Evidencia:** configuración aplicada por la API de GitHub el 26 nov 2026 y revisada después; plan Free de organización.

## Contexto
`railab-usach` pasó de cuenta compartida a organización el 26 nov 2026. Cada integrante entra con su propia cuenta y hay que decidir cómo queda configurado todo: quién puede hacer qué, cómo se protege `main` y qué ve alguien que llega al perfil. El estatuto pide código abierto y documentación pública.

## Decisión
| Ámbito | Configuración | Por qué |
|---|---|---|
| Perfil | Nombre «RAI Lab USACH», logo del león (del estatuto), descripción, Santiago, enlace a Instagram; README de presentación en el repo `.github` | Es la vitrina del lab: debe explicar en 30 segundos qué somos |
| Archivos comunes | `.github` con CONTRIBUTING, código de conducta, SECURITY y plantillas de issue y PR, que se aplican a todo repo que no tenga las suyas | Un solo lugar que se mantiene |
| Permiso base de miembros | Lectura; los miembros pueden crear repos públicos, no privados | Lo del lab es abierto por estatuto; nadie modifica un repo sin que lo agreguen |
| Rama `main` | Regla «main protegida» en cada repo: no se borra ni se reescribe; todo cambio entra por *pull request* con 1 aprobación, conversaciones resueltas, CI en verde y fusión *squash*. Los dueños de la organización pueden saltarse la regla | El CI y la revisión atrapan errores antes de que lleguen al robot; *squash* deja un commit por tarea |
| Ramas | Se borran solas al fusionar el PR | Mantiene limpio el repo |
| Seguridad | Escaneo de secretos con bloqueo de *push*, alertas y actualizaciones de Dependabot, reporte privado de vulnerabilidades; activado también para los repos nuevos | En el chat ya circularon claves; GitHub bloquea el push que contenga una |
| GitHub Actions | El token de los flujos queda en solo lectura y no puede aprobar PR | Mínimo privilegio |
| Wiki | Desactivada | La documentación vive en `docs/` de cada repo (vault de Obsidian) |
| Tablero | [GitHub Projects](https://github.com/orgs/railab-usach/projects/1), público, enlazado a los repos | Decisión de Camilo: todo en GitHub, sin más cuentas |
| Etiquetas | `mision`, `prueba`, `componente` (los tres niveles), `reto`, `bloqueado`, `decision` en todos los repos | Filtrar tareas por nivel |

## Lo que queda abierto
- **Dueños:** hoy son `CarryMankeke` y `railab-usach-admin` (la cuenta compartida). Falta invitar a Vicente como dueño con su cuenta personal, y después decidir si la cuenta compartida se mantiene solo como respaldo.
- **Verificación en dos pasos obligatoria:** recomendada, pero activarla saca de la organización a quien no la tenga. Se activa cuando todos los integrantes confirmen que la usan.
- **Licencia de `RobotBalancinSeguidorDeLinea`:** no tiene. La elige su equipo según el estatuto (MIT o GPL-3.0 para código, CERN-OHL-S v2 para hardware).
- **Licencias de hardware y documentación:** el estatuto pide CERN-OHL-S v2 para planos y piezas y CC BY-SA 4.0 para la documentación; los repos actuales declaran MIT. Se ajusta cuando se publiquen piezas y planos.

## Cómo se valida
Un PR de un integrante no se puede fusionar sin CI en verde y una revisión; un *push* con una clave de prueba conocida es bloqueado; el perfil muestra el logo y los proyectos.

Relacionado: [ADR-0006](0006-repositorios-y-licencia.md) · [índice](README.md)
