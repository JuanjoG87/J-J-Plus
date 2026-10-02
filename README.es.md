# J/J+

**Un lenguaje de programación de sistemas diseñado para que humanos e IA puedan razonar sobre el mismo código.**

[English](README.md)

J/J+ es un lenguaje experimental de sistemas desarrollado dentro del proyecto **OMEGA**.

La idea central es sencilla:

> Las decisiones importantes de un programa deberían poder entenderse leyendo el propio programa.

Qué puede leer una función, qué puede modificar, qué condiciones deben cumplirse y quién tiene autoridad sobre un recurso no deberían depender únicamente de convenciones, comentarios o suposiciones ocultas.

J/J+ intenta hacer esas relaciones explícitas y verificables mecánicamente.

Al mismo tiempo, el lenguaje está siendo construido para:

- compilarse a sí mismo;
- generar código para varias arquitecturas;
- producir resultados reproducibles;
- servir para desarrollar software de sistemas real;
- exponer hechos semánticos que humanos y herramientas automatizadas puedan inspeccionar.

> **Estado público:** Public Review 0.1  
> **Candidato técnico congelado:** `v0.1.0-preview.14`  
> **Estado:** Experimental · Código visible públicamente · No listo para producción

**Empieza aquí:** [Inicio rápido](docs/QUICKSTART.md#inicio-rápido-en-español) · [Release Public Review 0.1](https://github.com/MinOSPlus/J-J-Plus/releases/tag/public-review-0.1) · [Reproducibilidad](docs/REPRODUCIBILITY.md)

En Linux x86-64 (WSL2 sirve para esta ruta), el recorrido revisado más corto es:

```bash
git clone https://github.com/MinOSPlus/J-J-Plus.git
cd J-J-Plus
chmod +x bootstrap/linux_x86_64/jjc-root
bootstrap/linux_x86_64/jjc-root examples/HELLO_BUILD.txt hello.o
chmod +x hello.o
hello.o
```

El código de salida esperado es `0`. La guía completa también verifica los SHA-256 revisados.

> GitHub actualmente asocia la extensión `.j` con JASS. El repositorio oculta deliberadamente esa clasificación incorrecta hasta que J/J+ tenga una definición oficial en GitHub Linguist.

---

## Un pequeño ejemplo

```text
fn read_value(data:*i64)->i64
capability data;
reads data;
writes none;
{
    require data != 0 else return -1;

    return data[0];
}
```

Incluso sin conocer todavía todas las reglas de J/J+, podemos ver que:

- la función recibe `data`;
- `data` es una capability;
- la función puede leerla;
- la función declara que no escribe;
- `data` debe ser diferente de cero;
- de lo contrario devuelve `-1`.

El compilador conoce esas mismas relaciones de forma estructurada. No son solamente comentarios para una persona.

---

## Humanos e IA ven la misma semántica

J/J+ no consiste en escribir prompts dentro del código fuente y tampoco convierte a una IA en autoridad sobre el programa.

La dirección es diferente: **humanos y herramientas automatizadas deberían poder observar los mismos hechos semánticos.**

El compilador puede exponer información estructurada sobre elementos como:

```text
function
capability
reads / writes
condition
source span
provenance
authority
generation
control flow
diagnostic
```

Eso facilita responder preguntas sin adivinar:

- ¿qué memoria puede modificar esta función?
- ¿de dónde proviene este alias?
- ¿qué capability autoriza este acceso?
- ¿sigue activa esa autoridad?
- ¿qué condición protege este camino?
- ¿dónde nació esta propiedad en el código fuente?

---

## Programación de sistemas, no sólo sintaxis

J/J+ está siendo desarrollado como lenguaje de sistemas. Su diseño se pone bajo presión con trabajo real de bajo nivel relacionado con:

- compiladores;
- memoria;
- capabilities y autoridad;
- kernels;
- drivers;
- runtimes;
- software bare-metal;
- generación de código multi-arquitectura.

J/J+ forma parte del proyecto más amplio OMEGA, que también incluye investigación alrededor de **Super_Core**, **Minos** y **Polyglot**. Este repositorio, sin embargo, está deliberadamente centrado sólo en el lenguaje y el compilador.

---

## `require`: expresar una condición directamente

Una de las primeras construcciones del Public Review es:

```text
require <condición> else return <valor>;
```

Ejemplo:

```text
require data != 0 else return -1;
```

Su significado es directo: la ejecución puede continuar sólo si la condición es verdadera; de lo contrario, la función devuelve el valor indicado.

Internamente se transforma a flujo de control normal y no depende de una instrucción especial de una CPU concreta. Eso ayuda a mantener la semántica del lenguaje independiente del target.

---

## Efectos explícitos

J/J+ puede declarar efectos importantes de una función:

```text
capability data;
reads data;
writes none;
```

Esto permite que el compilador razone sobre qué puede observar o modificar una función y proporciona a las herramientas externas un contrato estructurado en lugar de obligarlas a reconstruir intención desde código máquina.

---

## Capabilities, provenance y autoridad

Una idea central es que **tener una referencia no crea automáticamente una nueva autoridad independiente**.

Por ejemplo:

```text
capability data;
```

establece una raíz de autoridad asociada a `data`.

Si se admite un puntero derivado o un alias, el compilador puede conservar su **provenance** —de dónde proviene— sin crear silenciosamente una nueva raíz de autoridad.

Conceptualmente:

```text
data
  ↓
alias
  ↓
alias + 8
```

puede seguir ligado al linaje de la capability original.

J/J+ distingue así dos preguntas relacionadas:

```text
provenance  → ¿de dónde viene este valor?
authority   → ¿quién puede utilizarlo ahora?
```

---

## La autoridad puede cambiar de estado

El Public Review actual contiene infraestructura interna para estados como:

```text
ACTIVE
TRANSFERRED
```

Conceptualmente:

```text
ACTIVE(source)
      ↓
transferencia interna
      ↓
TRANSFERRED(source)
ACTIVE(destination)
```

Un uso posterior del origen muerto puede ser rechazado en tiempo de compilación.

La sintaxis pública `transfer` **todavía no está expuesta**. Primero estamos demostrando las invariantes internas y después congelaremos la sintaxis superficial.

Ese trabajo incluye:

- identidad del destino;
- exactamente un linaje de autoridad activo;
- historial de generations;
- invalidación del origen después de una transferencia;
- conservación de alias/provenance;
- límites de lifetime;
- canales de escape;
- rechazo de colisiones y linajes malformados.

**Primero semántica; después sintaxis.**

---

## Diagnósticos estructurados

Los errores del compilador están diseñados para ser legibles por humanos y estables para herramientas.

Un diagnóstico puede contener campos como:

```text
code
reason_id
reason
expected
source_offset
line
column
token_length
```

Así, un IDE, analizador o agente de IA puede identificar una condición concreta sin tener que interpretar texto libre.

---

## Compilación reproducible

J/J+ trata la reproducibilidad como requisito central.

Una ruta típica de self-hosting es:

```text
fuente
  ↓
bootstrap compiler
  ↓
compiler G2
  ↓
compiler G3
```

Cuando:

```text
G2 == G3
```

byte por byte, el compilador alcanzó un fixed point: el compilador reconstruido vuelve a producir exactamente el mismo compilador.

---

## Tres linajes del compilador

Public Review 0.1 contiene tres linajes revisados:

```text
Root
Profile B
Diagnostic
```

No dependemos únicamente de que un compilador se reproduzca a sí mismo. También verificamos reconstrucciones cruzadas entre linajes.

Por ejemplo:

```text
Root       → Root
Profile B  → Root
Diagnostic → Root
```

Los resultados revisados deben coincidir byte por byte.

Esto no es una prueba formal de corrección. Es un mecanismo práctico de reproducibilidad y detección de divergencias.

---

## Self-hosting

J/J+ se desarrolla hacia una cadena canónica donde el lenguaje gobierne progresivamente su propio compilador:

```text
fuente J/J+
    ↓
compilador J/J+
    ↓
nuevo compilador J/J+
```

LLVM, GCC, Clang u otro framework externo no están destinados a convertirse en autoridad permanente de la ruta canónica. Pueden existir excepciones de bootstrap durante el desarrollo, pero no representan el destino arquitectónico.

---

## Targets revisados actualmente

| Arquitectura | Estado Public Review |
|---|---|
| x86-64 | Revisada |
| AArch64 | Revisada |
| ARM32 | Revisada |
| i386 | Revisada |

Esto no significa que todas las funciones del lenguaje estén terminadas en todos los targets. Significa que la ruta revisada del Public Review contiene evidencia para esas arquitecturas.

### ¿Por qué i386 sigue siendo importante?

i386 se conserva deliberadamente como **oráculo de presión**. Las restricciones de un target antiguo de 32 bits pueden revelar suposiciones ocultas, dependencias de registros, tamaños implícitos o complejidad innecesaria que pueden quedar invisibles en hardware moderno de 64 bits.

---

## Probar el compilador

En un entorno Linux x86-64 compatible:

```bash
chmod +x bootstrap/linux_x86_64/jjc-root
bootstrap/linux_x86_64/jjc-root examples/HELLO_BUILD.txt hello.o
chmod +x hello.o
./hello.o
```

Compilar el ejemplo con `require`:

```bash
bootstrap/linux_x86_64/jjc-root examples/GUARDED_BUILD.txt guarded.o
```

Compilar el ejemplo de efectos:

```bash
bootstrap/linux_x86_64/jjc-root examples/EFFECT_READ_BUILD.txt effect-read.o
```

Para la ruta completa de self-host revisada consulta [`docs/REPRODUCIBILITY.md`](docs/REPRODUCIBILITY.md).

---

## Reconstruir el compilador Root

```bash
bootstrap/linux_x86_64/jjc-root \
  spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt \
  root-g2.o

chmod +x root-g2.o
./root-g2.o \
  spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt \
  root-g3.o

cmp root-g2.o root-g3.o
sha256sum root-g2.o root-g3.o
```

El fixed point Root congelado de Preview.14 es:

```text
377a6990533d7a47020c3a149ba23eae3901c555913306abb26640329c6eecb3
```

Profile B:

```text
6c58f2dad44c2b6790945958ae055fececc122abcc78348af62da8316558886f
```

Diagnostic:

```text
4cec420e00517a6a27378bfeb818351b943ca041feb06e2f77bd7c9b39a3d2f9
```

---

## ¿Qué demuestra Public Review 0.1?

El candidato técnico congelado contiene evidencia revisada para áreas como:

- fixed points deterministas del compilador;
- reconstrucciones byte-exactas entre linajes;
- contratos `require`;
- diagnósticos estructurados;
- declarations de capabilities;
- contratos de efectos de lectura/escritura;
- propagación interprocedural de efectos;
- provenance de aliases;
- transformaciones de punteros admitidas;
- seguimiento de raíces de autoridad;
- infraestructura de invalidación del origen después de una transferencia;
- infraestructura de binding de autoridad del destino;
- outputs revisados x86-64, AArch64, ARM32 e i386;
- gates reproducibles desde una extracción limpia.

El release es deliberadamente limitado. Existe para que la arquitectura pueda ser inspeccionada antes de congelar más sintaxis pública.

---

## Lo que **no** afirmamos

Public Review 0.1 **no es**:

- un lenguaje listo para producción;
- J/J+ 1.0;
- una ABI congelada;
- un modelo completo de ownership;
- una biblioteca estándar completa;
- un compilador formalmente verificado;
- una afirmación de que cada componente ya está totalmente self-hosted en cada target;
- un reemplazo inmediato de lenguajes de sistemas maduros;
- software open source aprobado por OSI bajo la licencia actual.

---

## Estructura del repositorio

```text
.github/      plantillas de issues y pull requests
bootstrap/    compiladores bootstrap revisados y hashes
docs/         diseño, reproducibilidad, estado y limitaciones
evidence/     outputs de referencia y evidencia de revisión
examples/     programas J/J+ pequeños y manifests de build
spec/         manifests/especificaciones del compilador revisado
src_j/        código fuente J/J+ del compilador
tests/        gates positivos, negativos, semánticos y por target
```

Archivos principales:

```text
README.md
README.es.md
LICENSE
SECURITY.md
CONTRIBUTING.md
CHANGELOG.md
RELEASE_NOTES.md
SHA256SUMS_ALL.txt
```

---

## Relación con OMEGA

J/J+ nació dentro de **OMEGA**, un proyecto de investigación y desarrollo de sistemas originado en Paraguay.

OMEGA incluye trabajo en sistemas operativos, kernels, compatibilidad nativa, compiladores, interfaces, software bare-metal y arquitectura multi-target.

Este repositorio publica únicamente el **Public Review del lenguaje/compilador**. No publica los codebases completos de Super_Core, Minos, Polyglot ni las partes privadas de OMEGA.

---

## Evidencia antes que afirmaciones

Cuando una propiedad importante se considera cerrada intentamos conservar evidencia reproducible como:

- hashes;
- manifests;
- tests positivos y negativos;
- outputs de cross-build;
- outputs por target;
- clean-replay gates;
- artefactos de referencia revisados.

Por eso `evidence/` es deliberado. Los binarios de referencia no son basura accidental de compilación: sirven para realizar comparaciones byte-exactas.

---

## Contribuir

En esta etapa, encontrar un problema de diseño puede ser más valioso que añadir una feature.

Contribuciones especialmente útiles incluyen:

- reproducir builds;
- encontrar divergencias entre targets;
- detectar semántica ambigua;
- cuestionar invariantes de capabilities/authority;
- producir programas mínimos que fallen;
- revisar diagnósticos;
- mejorar documentación;
- probar el modelo semántico humano–IA;
- revisar la cadena self-host.

Consulta [`CONTRIBUTING.md`](CONTRIBUTING.md) antes de abrir un Pull Request.

---

## Seguridad

J/J+ es software experimental de sistemas. No recomendamos utilizar Public Review 0.1 como frontera de seguridad de producción.

Consulta [`SECURITY.md`](SECURITY.md) para reportar problemas sensibles.

---

## Licencia

Este Public Review se distribuye bajo el **OMEGA Research Source Notice** incluido en [`LICENSE`](LICENSE).

El repositorio puede inspeccionarse públicamente, pero la licencia actual no debe describirse como una licencia open source aprobada por OSI.

---

## ¿Por qué publicarlo tan temprano?

Esperar hasta 1.0 también tiene un costo. Si una decisión fundamental es incorrecta, es mejor descubrirlo antes de que decenas de otras decisiones dependan de ella.

Public Review 0.1 existe para que otras personas puedan cuestionar la arquitectura cuando todavía es posible cambiarla.

Si puedes romper una de nuestras invariantes, producir un caso contradictorio o demostrar que una regla puede simplificarse, **queremos saberlo**.
