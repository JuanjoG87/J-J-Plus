# Human-AI Convergence Model

J/J+ does not optimize separately for humans and AI agents. It optimizes for **shared semantic authority**.

## Human view

A human reviewer should be able to answer: what must be true, what can fail, what is read or changed, what authority is required, and where a diagnostic points in source.

## Structured view

A tool should be able to obtain stable semantic IDs, typed relationships, deterministic child ordering, source spans, diagnostic reason IDs and CIR relations without scraping prose or inferring intent from naming conventions.

## Convergence rule

Every future Human-AI feature must satisfy four gates:

1. Its source form is understandable without knowledge of compiler internals.
2. Its semantics have stable structured identity and source provenance.
3. The compiler verifies the promise the syntax makes.
4. Lowering is semantic and shared where possible, rather than keyword-specific in each backend.

A feature that only improves prose readability but cannot be verified is not sufficient. A feature that only improves machine structure but makes normal source harder to understand is also not sufficient.

## Declared versus observed effects

The effect contract demonstrates the convergence rule directly. Humans read names such as `capability`, `reads` and `writes`. Tools receive deterministic parameter masks plus both declared and compiler-observed effects. A declaration cannot become trusted merely because it is readable: the compiler must reconcile it with observed typed operations or reject the program.


## Interprocedural convergence

Preview.7 extends the same rule across function boundaries. A human sees an ordinary direct call between two functions whose authority/effect contracts are visible in source. The compiler emits a deterministic call-summary record (semantic index kind `11`) linking source span, argument role, callee identity and required read/write bits. The caller verifier consumes that record as observed effects.

There is no AI-only call graph language: the structured summary is derived from the same typed call expression and callee contract the human reads. If the compiler cannot prove the delegated authority, the call fails closed with `1509/6509` instead of asking an agent to infer safety.

## Provenance without a second language

Preview.7 applies the same Human-AI rule to a local pointer alias. The human writes ordinary J/J+:

```j
var alias:*i64 = data;
```

The compiler publishes deterministic semantic index kind `12`, version `1`, for each immediate alias edge, including source local and initializer store; the verifier resolves those edges to the originating capability parameter. Tools do not infer provenance from names or comments, and the human does not maintain a parallel metadata language. Both views derive from the same semantic event.

The admitted relation remains bounded: each alias is single-assignment, points to a parameter or strictly earlier admitted alias, and resolves to one capability root. Chains up to 64 edges are admitted; rebinding and depth above 64 fail closed with `1510/6510`.

Preview.8 extends the same rule to one transformed form already present in ordinary J/J+:

```j
var shifted:*i64 = data + 8;
```

The human still writes ordinary source. The compiler publishes semantic kind `13` for the pointer-plus-constant expression and kind `14` for the transformed alias edge. The verifier requires a constant byte offset, alignment to 8, an offset in `0..248`, and a provenance chain that still resolves to the same capability root. Dynamic or unsupported transforms fail closed with `1511/6511`; tools never have to infer pointer authority from text.

## Preview.12 authority-root state

Semantic index kind `16` gives every declared capability root a verified state record: function, root ordinal, `ACTIVE` state, generation `0`, source span and version. Alias chains and transformed provenance resolve back to this root; they do not create new authority. Preview.12 intentionally has no positive transfer transition. A future transfer must prove source, destination and post-transfer source invalidation before syntax is admitted.


## Preview.13 post-transfer source invalidation

Kind `16` now has an append-only authority state machine with `ACTIVE=1` and `TRANSFERRED=2`. Every effectful capability use is resolved through provenance to its root and must observe that root as ACTIVE at the use position. Test-only gates prove an internal transfer invalidates the source, creates an ACTIVE destination at the next generation, rejects source reuse, and supports a later chained transition. This is verifier infrastructure only: there is no public `transfer` syntax or destination-binding contract yet.

## Preview.14 destination identity and single authority

Preview.14 separates **permission provenance** from **current authority identity**. A declared capability remains the provenance/permission root, but an internal handoff may bind the next ACTIVE generation to an ordinary local pointer that is already proven to descend from the current owner. Semantic index kind `17` records that binding with destination local, original provenance root, generation, destination declaration span, transfer-event span and version.

The verifier therefore does not infer ownership from a variable name. It resolves ordinary provenance, asks kind `17` for the current authority identity, and then requires that identity to be ACTIVE in kind `16`. The gate proves that aliases created after a handoff resolve to the current owner rather than reviving an older source.

This remains a shared Human-AI semantic rule rather than a hidden agent-only annotation: the future source syntax, when admitted, must compile to this same deterministic ledger and binding evidence. Preview.14 deliberately stops before adding the public syntax.
