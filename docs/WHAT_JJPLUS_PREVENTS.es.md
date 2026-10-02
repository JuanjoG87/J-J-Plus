# Qué evita J/J+ hoy

Este documento muestra propiedades concretas impuestas por el compilador de Public Review 0.1 y por el gate de autoridad retenido de Preview.14.

## 1. Escribir con `writes none`

```j
fn bad(data:*i64)->i64
capability data;
reads none;
writes none;
{
  data[0] = 1;
  return 0;
}
```

Test:

```text
tests/effects/negative/undeclared_write.j
```

Resultado esperado:

```text
code=1507
reason=undeclared-write-effect
publication=NONE
```

La misma negativa se conserva en Root, Profile B y Diagnostic en `evidence/effects/NEGATIVE_MATRIX.tsv`.

## 2. Usar la autoridad vieja después de un handoff interno

Preview.14 todavía no expone una palabra clave pública `transfer`. Retiene un gate de prueba para el invariante subyacente.

Después de ligar la autoridad actual al local `next`:

```text
next[0]  -> aceptado
data[0]  -> rechazado
             code=1514
             reason=authority-source-transferred
             reason_id=6514
             published_outputs=0
```

Evidencia:

```text
evidence/authority_state/PREVIEW14_DESTINATION_BINDING_VERIFIER_GATE_RESULT.txt
tests/effects/authority_state/destination_binding_probe.j
```

Esto prueba infraestructura de estado de autoridad, no una sintaxis general de transferencia.

## Por qué importa

`1507` significa que una operación contradice el contrato de efectos. `1514` significa que el valor resuelve a una autoridad que ya no está ACTIVE.

Un buen review externo debe intentar encontrar un caso que rompa esas garantías: una escritura oculta aceptada bajo `writes none`, un alias que salte el contrato, una autoridad vieja todavía utilizable o un programa rechazado que publique un objeto.
