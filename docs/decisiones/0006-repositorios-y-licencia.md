---
title: "ADR-0006: repositorios, documentación y licencia"
date: 2026-11-24
estado: propuesta
tags: [adr, github, documentacion, licencia]
---
# ADR-0006: repositorios, documentación y licencia

- **Estado:** propuesta (lo de la cuenta compartida ya lo decidió Camilo el 24 nov)
- **Propone:** Camilo
- **Validado por:** —
- **Evidencia:** `gh api users/railab-usach` dice `type: User` (24 nov); el repo `balterriquelme-debug/Servidor-RAILAB` es público y tiene un solo commit con un README (19 nov).

## Contexto
El estatuto del lab («07 - Proyecto RAI Lab») declara el código abierto como pilar irrenunciable y pide documentación, código y planos de acceso libre en plataformas públicas. La cuenta de GitHub `railab-usach` es una cuenta personal compartida, no una organización. El código del servidor y del InMoov hoy vive suelto en cada equipo, sin git, y las decisiones no quedaron escritas.

Una **organización** de GitHub es gratis y no pide dominio ni que el lab sea oficial. Un dominio como `railab.cl` solo daría el sello de «dominio verificado».

## Opciones
| Opción | A favor | En contra |
|---|---|---|
| Repos personales | Ya existen | El código se va con la persona cuando egresa |
| Cuenta compartida `railab-usach` (decidido por ahora) | Queda en el lab | Clave compartida; no se sabe quién hizo cada cambio si todos entran con ella |
| Organización del lab | Cada uno con su cuenta; permisos por repo; gratis | Alguien tiene que crearla |

## Decisión
- **Dos repos públicos** en `railab-usach`, que se mueven a la organización cuando exista:
  - `railab-servidor`: la infraestructura del lab, que sirve a todos los proyectos.
  - `inmoov-cabeza`: el robot.
- Cada uno lleva su documentación como **vault de Obsidian** en el mismo repo, con enlaces markdown relativos para que se lea igual en GitHub. Para ver los dos en un solo grafo, se abre la carpeta que los contiene.
- Cada persona hace commits con **su propia cuenta**, como colaborador, aunque el repo sea de la cuenta compartida.
- Licencias: el código bajo **MIT**; la documentación bajo **CC BY-SA 4.0**. Las piezas 3D que vienen del InMoov de Gaël Langevin mantienen su licencia **CC BY-NC** (no comercial).
- Al ser públicos, GitHub Actions (revisión automática) y GitHub Pages (publicar los docs como sitio, por ejemplo con Quartz v5.2.2) son gratis.
- El README de Balter es el punto de partida de `railab-servidor` y se le da el crédito.

## Cómo se valida
Un integrante nuevo clona el repo, abre `docs/` en Obsidian o en GitHub y llega a cualquier documento en dos clics desde el índice.

## Consecuencias
Hay que agregar a cada integrante como colaborador. Cuando exista la organización, se transfieren los repos (GitHub redirige los enlaces viejos).

Relacionado: [índice de documentación](../README.md) · [índice](README.md)
