# J/J+

**A systems programming language designed so humans and AI can reason about the same code.**

[Español](README.es.md)

J/J+ is an experimental systems language developed inside the **OMEGA** project.

The central idea is simple:

> Important decisions in a program should be understandable from the program itself.

What a function may read, what it may modify, which conditions must hold, and who has authority over a resource should not depend only on conventions, comments, or hidden assumptions.

J/J+ tries to make those relationships explicit and mechanically inspectable.

At the same time, the language is being built to:

- compile itself;
- generate code for multiple architectures;
- produce reproducible outputs;
- support real low-level systems software;
- expose semantic facts that both humans and automated tools can inspect.

> **Public state:** Public Review 0.1  
> **Frozen technical candidate:** `v0.1.0-preview.14`  
> **Status:** Experimental · Source-visible · Not production-ready

---

## A small example

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

Even without knowing every J/J+ rule, a reader can already see that:

- the function receives `data`;
- `data` is a capability;
- the function may read it;
- the function declares no writes;
- `data` must be non-zero;
- otherwise the function returns `-1`.

The compiler tracks the same facts structurally. They are not only comments for a human reader.

---

## Humans and AI see the same semantics

J/J+ is not about writing prompts inside source code, and it does not make an AI the authority over a program.

The goal is different: **humans and automated reasoning tools should be able to inspect the same semantic facts.**

The compiler can expose structured information about things such as:

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

That makes questions like these easier to answer without guessing:

- What memory may this function modify?
- Where did this alias come from?
- Which capability authorizes this access?
- Is that authority still active?
- Which condition guards this path?
- Where in the source did this property originate?

---

## Systems programming, not just syntax

J/J+ is being developed as a systems language. Its design is pressured by real low-level work involving:

- compilers;
- memory;
- authority and capability tracking;
- kernels;
- drivers;
- runtimes;
- bare-metal software;
- multi-architecture code generation.

J/J+ is part of the wider OMEGA project, which also includes research around **Super_Core**, **Minos**, and **Polyglot**. This repository, however, is intentionally focused on the language and compiler only.

---

## `require`: make a condition explicit

One of the first Public Review language forms is:

```text
require <condition> else return <value>;
```

Example:

```text
require data != 0 else return -1;
```

Its meaning is straightforward: execution may continue only if the condition is true; otherwise the function returns the specified value.

Internally, this lowers to ordinary control flow rather than depending on a special CPU instruction, which helps keep the language semantics target-independent.

---

## Explicit effects

J/J+ can declare important function effects directly:

```text
capability data;
reads data;
writes none;
```

This lets the compiler reason about what a function is allowed to observe or change and gives external tools a structured contract instead of forcing them to infer intent from machine code.

---

## Capabilities, provenance, and authority

A central design idea is that **having a reference does not automatically create new independent authority**.

For example:

```text
capability data;
```

establishes an authority root associated with `data`.

If a derived pointer or alias is admitted, the compiler can preserve its **provenance**—where it came from—without silently creating a new authority root.

Conceptually:

```text
data
  ↓
alias
  ↓
alias + 8
```

can still remain tied to the original capability lineage.

J/J+ therefore distinguishes two related questions:

```text
provenance  → where did this value come from?
authority   → who is currently allowed to use it?
```

---

## Authority can change state

The current Public Review contains internal infrastructure for authority states such as:

```text
ACTIVE
TRANSFERRED
```

Conceptually:

```text
ACTIVE(source)
      ↓
internal handoff
      ↓
TRANSFERRED(source)
ACTIVE(destination)
```

A later use of the dead source can then be rejected at compile time.

Public `transfer` syntax is deliberately **not exposed yet**. The project is proving the underlying invariants before freezing the surface syntax.

That work includes:

- destination identity;
- exactly one active authority lineage;
- generation history;
- post-transfer source invalidation;
- alias/provenance preservation;
- lifetime boundaries;
- escape channels;
- collision and malformed-lineage rejection.

**Semantics first, syntax second.**

---

## Structured diagnostics

Diagnostics are intended to be readable by humans and stable enough for tooling.

A diagnostic can carry fields such as:

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

This means an IDE, analyzer, or AI agent can identify a specific compiler condition without scraping free-form English text.

---

## Reproducible compilation

J/J+ treats reproducibility as a core requirement.

A typical self-hosting path is:

```text
source
  ↓
bootstrap compiler
  ↓
compiler G2
  ↓
compiler G3
```

When:

```text
G2 == G3
```

byte-for-byte, the compiler has reached a fixed point: the rebuilt compiler produces exactly the same compiler again.

---

## Three compiler lineages

Public Review 0.1 carries three reviewed compiler lineages:

```text
Root
Profile B
Diagnostic
```

The project does not rely only on a compiler reproducing itself. Cross-lineage rebuilds are also checked.

For example:

```text
Root       → Root
Profile B  → Root
Diagnostic → Root
```

The reviewed results must agree byte-for-byte.

This is not a formal proof of compiler correctness. It is a practical reproducibility and divergence-detection mechanism.

---

## Self-hosting

J/J+ is being developed toward a canonical chain where the language increasingly governs its own compiler:

```text
J/J+ source
    ↓
J/J+ compiler
    ↓
new J/J+ compiler
```

LLVM, GCC, Clang, or another external compiler framework are not intended to become the permanent authority of the canonical language path. Bootstrap exceptions can exist during development, but they are not the architectural destination.

---

## Current reviewed targets

| Architecture | Public Review status |
|---|---|
| x86-64 | Reviewed |
| AArch64 | Reviewed |
| ARM32 | Reviewed |
| i386 | Reviewed |

This does not mean every language feature is finished on every architecture. It means the reviewed Public Review path contains target evidence for those architectures.

### Why i386 still matters

i386 is intentionally kept as a **pressure oracle**. Constraints on an older 32-bit target can reveal hidden assumptions, register dependencies, implicit widths, or unnecessary complexity that may stay invisible on modern 64-bit hardware.

---

## Try the compiler

On a compatible Linux x86-64 environment:

```bash
chmod +x bootstrap/linux_x86_64/jjc-root
bootstrap/linux_x86_64/jjc-root examples/HELLO_BUILD.txt hello.o
chmod +x hello.o
./hello.o
```

Build the guarded example:

```bash
bootstrap/linux_x86_64/jjc-root examples/GUARDED_BUILD.txt guarded.o
```

Build the effect-read example:

```bash
bootstrap/linux_x86_64/jjc-root examples/EFFECT_READ_BUILD.txt effect-read.o
```

For the complete reviewed self-host procedure, see [`docs/REPRODUCIBILITY.md`](docs/REPRODUCIBILITY.md).

---

## Rebuild the Root compiler

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

The frozen Preview.14 Root fixed point is:

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

## What Public Review 0.1 demonstrates

The frozen technical candidate contains reviewed evidence for areas including:

- deterministic compiler fixed points;
- cross-lineage byte-exact rebuilds;
- `require` contracts;
- structured diagnostics;
- capability declarations;
- read/write effect contracts;
- interprocedural effect propagation;
- alias provenance;
- admitted pointer transformations;
- authority-root tracking;
- post-transfer source invalidation infrastructure;
- destination authority binding infrastructure;
- x86-64, AArch64, ARM32, and i386 reviewed outputs;
- clean-extraction reproducibility gates.

The release is intentionally narrow. It exists so the architecture can be inspected before more surface syntax is frozen.

---

## What we do **not** claim

Public Review 0.1 is **not**:

- production-ready;
- J/J+ 1.0;
- ABI-frozen;
- a complete ownership model;
- a complete standard library;
- a formally verified compiler;
- a claim that every component is already fully self-hosted on every target;
- an immediate replacement for mature systems languages;
- OSI-approved open-source software under the current license.

---

## Repository layout

```text
.github/      GitHub issue and pull-request templates
bootstrap/    reviewed bootstrap compilers and hashes
docs/         design, reproducibility, status, limitations
evidence/     sealed reference outputs and review evidence
examples/     small J/J+ programs and build manifests
spec/         reviewed compiler build/specification manifests
src_j/        J/J+ compiler source
tests/        positive, negative, semantic, and target gates
```

Root files include:

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

## Relationship to OMEGA

J/J+ originated inside **OMEGA**, a systems research and development project from Paraguay.

OMEGA includes work on operating systems, kernels, native compatibility, compilers, interfaces, bare-metal software, and multi-target architecture.

This repository publishes the **language/compiler Public Review** only. It does not publish the complete Super_Core, Minos, Polyglot, or private OMEGA codebases.

---

## Evidence over claims

When an important property is considered closed, the project tries to preserve reproducible evidence such as:

- hashes;
- manifests;
- positive and negative tests;
- cross-build outputs;
- target outputs;
- clean-replay gates;
- reviewed reference artifacts.

The `evidence/` directory is therefore intentional. Binary reference outputs are not accidental build leftovers; they exist to make byte-exact comparisons possible.

---

## Contributing

At this stage, finding a design problem can be more valuable than adding a feature.

Useful contributions include:

- reproducing builds;
- finding target divergence;
- identifying ambiguous semantics;
- challenging authority/capability invariants;
- producing minimal failing programs;
- reviewing diagnostics;
- improving documentation;
- testing the human–AI semantic model;
- reviewing the self-host chain.

See [`CONTRIBUTING.md`](CONTRIBUTING.md) before opening a pull request.

---

## Security

J/J+ is experimental systems software. Do not rely on Public Review 0.1 as a production security boundary.

See [`SECURITY.md`](SECURITY.md) for reporting guidance.

---

## License

This Public Review is distributed under the **OMEGA Research Source Notice** included in [`LICENSE`](LICENSE).

The repository is publicly inspectable, but the current license should not be described as an OSI-approved open-source license.

---

## Why publish this early?

Waiting until 1.0 also has a cost. If a fundamental design decision is wrong, it is better to discover that before dozens of other decisions depend on it.

Public Review 0.1 exists so other people can challenge the architecture while it is still possible to change it.

If you can break one of our invariants, produce a contradictory case, or show that a rule can be made simpler, **we want to know**.
