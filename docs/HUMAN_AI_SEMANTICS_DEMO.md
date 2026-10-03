# Human-AI Semantics Demo

[Español](HUMAN_AI_SEMANTICS_DEMO.es.md)

The Human-AI direction in J/J+ is **not** the claim that structured diagnostics are unique. Mature compilers already expose machine-readable diagnostics.

The narrower claim is that J/J+ is designing important program relations as stable compiler semantics that both a human reader and a tool/agent can inspect without maintaining separate interpretations.

## One source contract

Consider:

```j
fn first(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}
```

A human can read:

```text
data is an authority-bearing input
the function may read data
the function may not write data
the body reads data[0]
```

The compiler records the same relation in semantic index kind `10`.

The inspection API exposes fields for:

```text
function
capability mask
declared reads
declared writes
observed reads
observed writes
contract version
```

Implementation:

```text
src_j/compiler/frontend/semantic_inspection_api.j
```

Stable IDs:

```text
spec/JJP_HUMAN_AI_SEMANTIC_IDS_V1.json
```

## A tool does not need to infer the contract from prose

A tool can ask the semantic surface, conceptually:

```text
declared_writes(function) == 0
observed_writes(function) == 0
capability(data) == true
observed_reads(data) == true
```

If the body changes to:

```j
data[0] = 1;
```

the compiler does not merely emit different English text. The observed effect contradicts the declared relation and compilation fails with stable identity:

```text
code=1507
reason_id=6507
reason=undeclared-write-effect
```

## Authority is also structured

Public Review 0.1 also contains structured authority records:

```text
kind 16 -> authority state / generation
kind 17 -> destination authority binding
```

That lets tooling reason about questions such as:

```text
What is the provenance root?
Which identity is ACTIVE?
What generation is current?
Is this later source use stale?
Where in the source did the relation originate?
```

The retained Preview.14 verifier gate demonstrates a destination use that is accepted followed by an old-source use rejected as `1514/6514`.

## What makes this different from "compiler JSON"

JSON, text, or another serialization format is only transport.

The intended differentiator is that capabilities, effects, provenance, authority state, generations, and source spans are **first-class semantic relations produced by the compiler**, with stable identities and an inspection surface.

An AI agent is not given a second hidden language and is not made authoritative over compilation. It consumes the same compiler-governed relations available to other tools and to human review.

## Current limit

This is still an experimental foundation, not proof that J/J+ is uniquely superior for AI-assisted programming.

The project still needs stronger public demonstrations, including:

- a non-trivial program using several of these relations together;
- an external tool that consumes the inspection API end-to-end;
- independent reviewers attempting to falsify the same invariants.

Until those exist, the accurate claim is:

> J/J+ exposes a shared structured semantic surface intended for both human review and automated reasoning; the broader Human-AI productivity claim remains under evaluation.
