# What J/J+ Prevents Today

This document shows concrete properties enforced by the **production Public Review 0.1 compiler** and by the retained Preview.14 authority-state gate.

The point is not that J/J+ already has a complete ownership system. It does not. The point is that unsupported or contradictory authority/effect behavior fails closed instead of being accepted silently.

## 1. Writing through a capability declared `writes none`

Source:

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

Repository test:

```text
tests/effects/negative/undeclared_write.j
tests/effects/negative/undeclared_write_BUILD.txt
```

The compiler observes a write through `data`, but the function declared `writes none`.

Expected result:

```text
code=1507
reason=undeclared-write-effect
publication=NONE
```

The same rejection is preserved across Root, Profile B, and Diagnostic in:

```text
evidence/effects/NEGATIVE_MATRIX.tsv
```

This is a production-language check, not a comment or lint warning.

## 2. Using the old authority after an internal handoff

Preview.14 deliberately does **not** expose a public `transfer` keyword. Instead, it retains a test-only verifier gate for the underlying invariant.

Probe:

```j
fn p14probe(data:*i64)->i64
capability data;
reads data;
writes none;
{
  var next:*i64 = data;
  var first:i64 = next[0];
  var second:i64 = data[0];
  return first+second;
}
```

The gate binds the current authority to the ordinary local identity `next`.

The first access is accepted:

```text
next[0]  -> accepted
```

The later use of the old source is rejected:

```text
data[0]
  -> code=1514
  -> reason=authority-source-transferred
  -> reason_id=6514
  -> published_outputs=0
```

The retained result is:

```text
evidence/authority_state/PREVIEW14_DESTINATION_BINDING_VERIFIER_GATE_RESULT.txt
```

and the exact source is:

```text
tests/effects/authority_state/destination_binding_probe.j
```

Important boundary: this is evidence for the authority-state machinery underneath a future transfer surface. It is **not** a claim that general source-level transfer syntax is already available.

## 3. Why these examples matter

The two failures are different:

```text
1507 -> the operation contradicts the declared effect contract
1514 -> the value resolves to authority that is no longer ACTIVE
```

So the compiler is not merely matching text patterns. It distinguishes:

- declared permissions;
- observed memory effects;
- provenance;
- current authority state;
- source location;
- output-publication policy.

## Try to break it

Useful external review is not limited to reproducing hashes. Good findings include:

- a program that performs a hidden write but is accepted under `writes none`;
- an alias or transformed pointer that bypasses the effect contract;
- a post-handoff source use that remains accepted;
- two simultaneous ACTIVE authorities for one provenance root;
- a rejected program that nevertheless publishes an output object.

Minimal contradictory cases are especially valuable.
