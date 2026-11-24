---
title: "ADR-0004: servidor de modelos de lenguaje y API estándar"
date: 2026-11-24
estado: propuesta
tags: [adr, servidor, ia, llm]
---
# ADR-0004: servidor de modelos de lenguaje y API estándar

- **Estado:** propuesta
- **Propone:** Camilo (auditoría del 24 nov 2026)
- **Validado por:** —
- **Evidencia:** foto del 17 nov (Ollama respondiendo en `hp-node-01` con un modelo en modo «thinking»); foto del 16 nov (el notebook devuelve «Error en Ollama, código 404»); CPUID 206D7 en la BIOS; [biblioteca de Ollama](https://ollama.com/library) consultada el 24 nov; [versiones](../../README.md#versiones); inventario por SSH del 24 nov (tarde): Ollama 0.40.16 con seis modelos `qwen3` de 0,6B a 4B, GPU Quadro 600 confirmada y el código del cerebro, que usa la API propia de Ollama (`/api/generate`) con `qwen3:1.7b` y el modo «thinking» apagado ([ficha](../hardware/hp-node-01.md)).

## Contexto
El 17 nov, Emilio instaló Ollama en `hp-node-01`. El Xeon E5-1607 es Sandy Bridge: tiene AVX pero **no AVX2**, y por eso la inferencia en CPU usa un camino más lento (cuánto más lento está **no verificado**). La NVIDIA del servidor (una Quadro 600 de 1 GB, confirmada con `lspci`) es de la generación Fermi, que los drivers actuales no soportan: no sirve para IA.

El modo «thinking» hace que el modelo escriba su razonamiento antes de responder. Eso multiplica los tokens y la espera, y para una conversación hablada es demasiado lento. El error 404 del notebook suele significar que el modelo no estaba descargado o que el nombre estaba mal escrito (**no verificado**).

## Qué significa «API estándar»
No es un servicio pagado. Ollama y llama.cpp exponen en la red del lab una interfaz HTTP con **el mismo formato que usan los servicios comerciales** (`POST /v1/chat/completions`). Nuestro código solo conoce ese formato y dos variables: `LLM_BASE_URL` (a quién se le pregunta) y `LLM_MODEL` (qué modelo). Cambiar del Xeon a la GPU de norea-node, o a otro motor, es cambiar esas variables sin tocar el código. Todo corre en equipos del lab y cuesta $0.

## Opciones
| Opción | A favor | En contra |
|---|---|---|
| Ollama v0.40.17 (MIT) | Se instala con un comando; baja modelos por nombre; trae la API estándar en `/v1` | Menos control fino de hilos y memoria |
| llama.cpp `llama-server` v1.0.0 (MIT) | Es el mismo motor, con control total (hilos, contexto, gramáticas); misma API estándar | Hay que bajar y elegir los archivos GGUF a mano |
| vLLM u otros motores para GPU | Mucho más rápidos con GPU | El servidor no tiene una GPU útil |

## Decisión
- **Ollama** como servidor de modelos, con el modo «thinking» apagado para conversar.
- Todo cliente usa la **API estándar**, nunca la API propia de Ollama.
- El modelo se elige con una medición (reto de la etapa E0) entre `qwen3.5:2b`, `qwen3.5:4b`, `gemma4:e2b`, `gemma4:e4b`, `llama3.2:3b` y, desde la [revisión de arquitectura](https://github.com/railab-usach/inmoov-cabeza/blob/main/docs/revision-arquitectura.md), `lfm2`, `granite4` y `ministral-3`, que están hechos para correr en CPU. Los ocho nombres existen en la biblioteca de Ollama al 24 nov. La licencia de LFM2 no es Apache: hay que revisarla antes de fijarlo.

## Por qué Ollama y no llama.cpp directo
Ollama usa por dentro el mismo motor de llama.cpp. norea-node ya corre Ollama (en Docker, con `qwen3.5:4b`), así que en los dos equipos se usarían los mismos nombres de modelo y una sola herramienta que aprender. La duda real es el Xeon sin AVX2: un `llama-server` compilado en esa misma máquina (`-march=native`) podría rendir más que los binarios genéricos de Ollama (**no verificado**). Como el cliente solo conoce la API estándar, cambiar de motor no toca el código. Por eso el reto E0-4 mide **los dos motores** con el mismo modelo, y si llama.cpp gana por más de un 20 %, se reemplaza Ollama en un ADR nuevo.

## Cómo se valida
Un script `herramientas/bench_llm.py` mide, con 10 preguntas fijas en español, el tiempo hasta el primer token, los tokens por segundo y si la respuesta es correcta, ingenua o inventada. Gana el modelo más chico que responda bien en menos de 2 s hasta la primera oración (**meta, no verificado** que el Xeon la alcance).

## Consecuencias
Si ningún modelo cumple en el Xeon, el LLM pasa a norea-node (GTX 1060) y esta decisión no cambia: solo cambia `LLM_BASE_URL`.

Además: se quitan del servidor las librerías de NVIDIA 620.70 que alguien instaló, porque no tienen driver para Fermi y `nvidia-smi` falla. El cerebro actual pasa de `/api/generate` a la API estándar.

Relacionado: [ADR-0001](0001-sistema-operativo.md) · [ficha de hp-node-01](../hardware/hp-node-01.md) · [índice](README.md)
