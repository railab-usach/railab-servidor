---
title: "ADR-0007: plataforma de comunicación del lab"
date: 2026-11-24
estado: propuesta
tags: [adr, comunicacion, herramientas]
---
# ADR-0007: plataforma de comunicación del lab

- **Estado:** propuesta
- **Propone:** Camilo (24 nov 2026)
- **Validado por:** —
- **Evidencia:** planes y documentación consultados el 24 nov 2026: [Zulip](https://zulip.com/plans/), [límites del plan gratis de Slack](https://slack.com/help/articles/115002422943), [conector de Slack para Claude](https://claude.com/docs/connectors/slack), [conector de Slack para ChatGPT](https://help.openai.com/en/articles/12525822-chatgpt-connector-for-slack), [Mattermost](https://docs.mattermost.com/product-overview/editions-and-offerings.html).

## Contexto
Hoy el lab coordina por un grupo de WhatsApp. Ahí las conversaciones se mezclan, las claves terminaron circulando en texto plano y nada se puede buscar ni enlazar desde los repos. Lo que se busca:
1. Que se pueda revisar **desde el celular y desde el PC**.
2. **Que Claude o GPT puedan leerla**, para resumir, buscar decisiones y redactar.
3. **Plan gratis:** el lab no tiene presupuesto.
4. Que el historial no se pierda y que las conversaciones se ordenen por tema.

**Lo que se averiguó sobre el criterio 2.** Ningún plan gratis trae el conector oficial de una IA:
- El conector de Slack en claude.ai es solo para los planes Team y Enterprise de Claude.
- El de ChatGPT pide Plus o un plan superior.

En cambio, **Claude Code** (incluido en Claude Pro) llega a cualquier plataforma que tenga una API abierta, con un bot y su llave, o con un servidor MCP. Por eso, en la práctica, el criterio 2 se cumple con cualquier opción que tenga una API buena. GPT sin plan pagado no tiene una vía equivalente (**no verificado** para otras herramientas de OpenAI).

## Opciones
| Opción | Plan gratis | Celular y PC | Cómo llega Claude | Contra |
|---|---|---|---|---|
| WhatsApp (hoy) | Sí | Sí | No hay API para grupos personales | Todo mezclado; sin búsqueda útil; las claves circulan |
| **Zulip Cloud** | Free: búsqueda en los últimos 10.000 mensajes y 5 GB de archivos. Los proyectos de código abierto y los grupos de investigación pueden pedir **Standard gratis** (patrocinio) | Apps oficiales | API REST completa y bots gratis; hay servidores MCP de la comunidad (por ejemplo `zulipchat-mcp`, MIT) | Poca gente lo conoce; el patrocinio hay que pedirlo y que lo aprueben (**no verificado**) |
| Slack Free | Sí: solo se ven los últimos 90 días; 10 apps como máximo; llamadas grupales solo pagando | Apps oficiales | Servidor MCP oficial de Slack desde Claude Code; el conector de claude.ai, solo en Team o Enterprise | El historial se esconde a los 90 días: el lab pierde su memoria |
| Discord | Sí, sin límite de historial | Apps oficiales | Bot con llave y servidores MCP de la comunidad (ninguno oficial para leer mensajes) | Hilos poco ordenados; pensado para comunidades de juegos |
| Telegram | Sí, sin límite | Apps oficiales | Bot con llave; servidores MCP de la comunidad | Sin integración con GitHub de serie; los bots en grupos necesitan configuración |
| Zulip o Mattermost en `hp-node-01` | Sí (software libre) | Sí, pero el celular necesita llegar al servidor | Igual que Zulip Cloud | Hay que mantenerlo y exponerlo: hoy el servidor solo se alcanza por Tailscale. Las notificaciones al celular de Zulip propio son gratis solo hasta 10 usuarios o con el plan Community (**no verificado** el detalle de 2026) |
| Google Chat (cuentas de la USACH) | Incluido en la cuenta universitaria | Sí | La API de Chat pide una app autorizada por el administrador de la USACH | Depende de la universidad; integrantes sin correo USACH quedan fuera |

## Decisión
- **Zulip Cloud.** Se pide el patrocinio Standard como laboratorio de código abierto de una universidad. Si no lo aprueban, se usa el plan Free: 10.000 mensajes alcanzan para meses de un lab chico.
- **Canales** (en Zulip, *streams*): `general`, `servidor`, `inmoov`, y uno por cada proyecto nuevo. Dentro de cada canal, un **tema por reto o por ADR**, para que cada conversación quede ordenada.
- La **integración con GitHub** publica en cada canal los *commits* y *pull requests* de su repo.
- **Bot de lectura para Claude:** un bot con su propia llave, guardada fuera de los repos, solo en los canales que el grupo apruebe. Los integrantes saben qué canales lee y para qué.
- **Reglas:**
  - Nada de claves ni IPs en el chat; las claves se pasan en persona o con un gestor de contraseñas.
  - Las decisiones no se toman en el chat: se proponen en un ADR del repo.
- WhatsApp queda solo para avisos urgentes durante el primer mes.

## Cómo se valida
1. Dentro de dos semanas, todos los integrantes tienen la app en el celular y escribieron en su canal.
2. Desde Claude Code, el bot lee un tema y devuelve un resumen fiel, con enlaces a los mensajes.
3. Al mes, ninguna clave quedó en el chat y WhatsApp no tiene conversaciones de trabajo.

## Consecuencias
- Alguien del lab crea la organización y pide el patrocinio (Vicente o Camilo).
- Que el bot lea el chat significa que esos mensajes pasan por el servicio de IA que se use. Hay que acordarlo en la reunión y anotarlo aquí.
- Si en el futuro el lab paga Claude Team, Slack ganaría por su conector oficial. Esta decisión se reabre en ese caso.

Relacionado: [ADR-0002](0002-red-tailscale.md) · [ADR-0003](0003-acceso-ssh.md) · [índice](README.md)
