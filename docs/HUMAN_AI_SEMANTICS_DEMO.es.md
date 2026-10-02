# Demo de semántica Humano–IA

La dirección Humano–IA de J/J+ **no** afirma que los diagnósticos estructurados sean únicos. Compiladores maduros ya ofrecen diagnósticos legibles por máquinas.

La afirmación es más estrecha: J/J+ diseña relaciones importantes del programa como semántica estable del compilador que humanos y herramientas/agentes pueden inspeccionar sin mantener dos interpretaciones distintas.

## Un mismo contrato

```j
fn first(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}
```

Un humano puede leer que `data` es capability, puede leerse y no puede escribirse. El compilador registra esa misma relación en el índice semántico kind `10`.

La API de inspección expone función, capability mask, reads/writes declarados, reads/writes observados y versión del contrato.

Implementación:

```text
src_j/compiler/frontend/semantic_inspection_api.j
```

IDs estables:

```text
spec/JJP_HUMAN_AI_SEMANTIC_IDS_V1.json
```

Si el cuerpo cambia a `data[0] = 1;`, la relación observada contradice el contrato y falla con `1507/6507`.

## Autoridad estructurada

Public Review 0.1 también contiene:

```text
kind 16 -> estado/generación de autoridad
kind 17 -> binding de autoridad destino
```

Eso permite consultar provenance root, identidad ACTIVE, generación actual, stale use y ubicación de origen.

## Qué lo diferencia de “JSON del compilador”

JSON, texto u otro formato son sólo transporte. La intención diferenciadora es que capabilities, efectos, provenance, autoridad, generaciones y source spans sean **relaciones semánticas de primera clase producidas por el compilador**.

Una IA no recibe un lenguaje oculto ni autoridad especial: consume las mismas relaciones gobernadas por el compilador que otras herramientas y que la revisión humana.

## Límite actual

Todavía faltan un programa público no trivial que combine estas relaciones, una herramienta externa end-to-end que consuma la inspection API y revisores independientes intentando falsificar los invariantes.

La afirmación correcta hoy es:

> J/J+ expone una superficie semántica estructurada compartida para revisión humana y razonamiento automatizado; la afirmación más amplia de productividad Humano–IA sigue en evaluación.
