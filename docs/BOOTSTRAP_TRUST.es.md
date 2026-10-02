# Límite de confianza del bootstrap

Public Review 0.1 es reproducible **a partir de los binarios bootstrap incluidos en este repositorio**. Eso es una propiedad importante, pero no equivale a demostrar la corrección semántica ni el origen independiente de esos binarios.

## Límite público de confianza

La ruta hosted pública comienza con:

```text
bootstrap/linux_x86_64/jjc-root
bootstrap/linux_x86_64/jjc-profile
bootstrap/linux_x86_64/jjc-diagnostic
```

Sus hashes están registrados en `bootstrap/linux_x86_64/SHA256SUMS.txt`.

A partir de esas semillas el repositorio demuestra fixed points por linaje, G2=G3 byte-exacto, reconstrucciones cruzadas y reproducción de gates positivos/negativos y outputs multi-target seleccionados.

## Qué prueba un fixed point

`G2 == G3` byte por byte demuestra **determinismo y autoconsistencia** para ese source/build.

No demuestra por sí solo que el compilador implemente correctamente toda la semántica prevista, que la primera semilla sea confiable, que esté libre de un ataque tipo trusting-trust ni que el compilador esté formalmente verificado.

## Origen histórico

El repositorio público actual no contiene una cadena independiente completa que reconstruya el primer bootstrap hosted desde una semilla externa más pequeña.

Los tres binarios fueron producidos por el linaje J/J+ previo a la publicación. Public Review 0.1 comienza deliberadamente en esos binarios y hace explícito ese límite.

## Cómo reducir ese límite

Trabajo futuro útil incluye preservar un bootstrap más pequeño y documentado, reproducir una semilla desde una implementación independiente, aplicar técnicas de compilación diversa cuando sean prácticas y obtener reproducciones externas independientes.

La afirmación correcta hoy es:

> J/J+ Public Review 0.1 es reproducible desde las semillas bootstrap publicadas; no afirma una cadena bootstrap libre de semillas ni formalmente verificada.
