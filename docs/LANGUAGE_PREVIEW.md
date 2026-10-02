# J/J+ Language Preview 0.1

## Design objective

A J/J+ program should state enough intent for a human to review it while retaining enough deterministic structure for a compiler, verifier or agent to reason about it without guessing.

The source language is authoritative. Structured metadata is a reflection of source semantics, not a second privileged language.

## Functions and scalar types

Current review examples use the established J/J+ function form:

```j
fn name(value:i64)->i64 {
  return value;
}
```

## Preconditions with explicit failure policy

```j
fn guarded(value:i64)->i64 {
  require value != 0 else return 7;
  return 9;
}
```

Human interpretation: continuing past the statement requires `value != 0`; otherwise the function returns `7`.

Compiler interpretation: a typed `require` statement (stable kind 13) owns a condition relation, a branch relation and an explicit return relation. The existing conditional branch/jump/return CIR operations implement the control flow.

There is intentionally no short form such as `require condition;` because it would hide failure policy.

## Structured diagnostics

Require diagnostics have stable semantic codes:

| Code | Reason ID | Meaning |
|---:|---:|---|
| 1401 | 6401 | missing `else` |
| 1402 | 6402 | missing `return` |
| 1403 | 6403 | invalid condition |
| 1404 | 6404 | invalid/narrow condition authority |
| 1405 | 6405 | invalid failure expression |
| 1406 | 6406 | failure type mismatch |
| 1407 | 6407 | missing semicolon |

A diagnostic carries human-readable `reason` and `expected` fields plus stable numeric identities and source location information.

## Semantic identities

The machine-readable registry is `spec/JJP_HUMAN_AI_SEMANTIC_IDS_V1.json`. Numeric IDs remain stable at the semantic boundary while compiler source uses semantic names at important Human-AI call-sites.

## Deferred syntax

`ensures`, `invariant` and explicit ownership/borrowing syntax remain design work for later reviews. `capability`, `reads` and `writes` are admitted only in the bounded verified form below; declaration-only effects that the compiler cannot prove are not accepted.

## Verified authority and direct effects

Review 0.1 admits a bounded effect contract:

```j
fn first(data:*i64)->i64
capability data;
reads data;
writes none;
{
  return data[0];
}
```

The clauses are semantic contracts, not documentation. In this review:

- effect targets must be pointer parameters;
- `reads` and `writes` must be subsets of `capability`;
- direct indexed accesses are measured by the typed operand tree;
- observed reads/writes must be covered by the declarations;
- duplicate targets, scalar targets, undeclared effects and unsupported pointer escapes fail closed;
- `none` represents an empty set.

The compiler records both declared and observed bit masks in semantic index record kind `10`, version `1`. The public inspection API exposes these fields so tools do not need to scrape source text.

This is intentionally not a general alias/effect system. Preview.9 admits bounded direct internal-call propagation, acyclic single-assignment local alias chains rooted at a capability parameter, and one transformed form: `pointer + constant-byte-offset` with 8-byte alignment and a `0..248` byte bound. Rebinding, provenance depth above 64, dynamic/subtractive/unbounded transforms, external call effects and general alias escape remain outside the admitted subset.

### Effect diagnostics

| Code | Reason ID | Meaning |
|---:|---:|---|
| 1501 | 6501 | incomplete effect contract |
| 1502 | 6502 | effect clauses are out of canonical order |
| 1503 | 6503 | target is not a pointer parameter |
| 1504 | 6504 | duplicate target |
| 1505 | 6505 | effect is outside declared capability |
| 1506 | 6506 | observed read is not declared |
| 1507 | 6507 | observed write is not declared |
| 1508 | 6508 | unsupported capability escape/alias shape |
| 1509 | 6509 | capability delegated to an internal callee without a verifiable effect contract |
| 1510 | 6510 | alias provenance cannot be proved within the bounded acyclic model |
| 1511 | 6511 | pointer transform cannot be proved within the bounded constant-offset model |
| 1512 | 6512 | capability-derived pointer escapes through `return` without an explicit transfer contract |
| 1513 | 6513 | capability-derived value is encoded and stored/published without an explicit transfer contract |
| 1514 | 6514 | capability use resolves to an authority root already marked `TRANSFERRED` at that source position |

### ARM32 bounded constant indices

For `data:*i64`, ARM32 currently admits direct reads `data[n]` for constant `n` from `0` through `31`. The common lowering represents nonzero indices with CIR `ADDRESS_OFFSET` before `LOAD`; the ARM32 emitter encodes the resulting byte offset in an immediate `LDRD`.

`data[32]` and larger are rejected for ARM32 with:

```text
code=1601 reason=arm32-direct-load-index-range reason_id=6601
expected=constant-index-0-through-31
```

This is a target capability diagnostic, not an effect-contract violation. Dynamic indices remain outside Review 0.1.


## Bounded interprocedural propagation

A contracted function may directly forward one of its capability parameters to a previously defined internal function with a verified effect contract. For each pointer argument that is itself a callee capability, the compiler records a semantic call summary (index kind `11`, version `1`) containing the source span, argument role, callee function ID and required read/write bits.

During caller verification those required bits are folded into the caller's **observed** effects. Therefore a caller cannot hide a callee read behind `reads none` or a callee write behind `writes none`. A delegated capability whose callee contract cannot be verified fails closed with `1509/6509`.

The public inspection API exposes the call-summary fields directly. This preserves the Human-AI rule: humans read the same `capability`/`reads`/`writes` declarations, while tools consume stable structured relations derived from them.

The admitted delegated form is direct forwarding of a capability parameter, a verified local alias chain rooted at that parameter, or the bounded constant-offset transformed provenance described below. Dynamic transforms, rebinding, external calls and general aliasing are not inferred.

## Bounded alias provenance

Preview.7 adds no alias keyword. Ordinary local syntax is used:

```j
var a:*i64 = data;
var b:*i64 = a;
return read0(b);
```

For each admitted edge the compiler publishes alias provenance record kind `12`, version `1`. The record binds the alias local ordinal to its immediate source ordinal, initializer store and source spans. The verifier requires `source_ordinal < alias_ordinal` and follows the chain to the declared capability root. Observed effects through every alias are attributed to that root.

The provenance is intentionally single-assignment and bounded to 64 alias edges. Rebinding or depth above 64 fails with `1510/6510 effect-alias-unverified`.

## Bounded transformed provenance

Preview.8 admits one pointer transformation already present in normal J/J+ syntax:

```j
var shifted:*i64 = data + 8;
return read0(shifted);
```

The offset is measured in bytes. During expression parsing the compiler publishes semantic record kind `13`, version `1`, containing the expression node, source local, constant byte offset, source span and `+` operator identity. When that expression initializes a pointer local, kind `14`, version `1`, binds the new alias to the source local and verified offset.

The verifier requires:

- a literal constant offset rather than a dynamic value;
- `+` as the admitted transform operator;
- byte offset `0..248`;
- alignment to 8 bytes;
- accumulated transformed offset across the provenance chain no greater than 248 bytes;
- the complete chain resolving to one declared capability root.

`+1`, `+256` and dynamic offsets fail closed with `1511/6511 effect-pointer-transform-unverified` and publish no output. AArch64 and i386 lower the admitted source through their normal target route. ARM32 consumes the same kind `13/14` evidence and normalizes the bounded wrapper to CIR `ARG -> ADDRESS_OFFSET -> LOAD -> RETURN` rather than inventing a general pointer-arithmetic ABI.


## Return escape classification

Preview.9 classifies one escape intention independently of representation. In a contracted function, each of these is rejected:

```j
return data;
return alias;
return shifted;
```

when the returned pointer resolves to declared capability provenance. All three produce:

```text
code=1512 reason=effect-return-escape-unverified reason_id=6512
expected=non-escaping-capability-use-or-future-explicit-transfer-contract
```

This does not transfer authority. It makes a previously representation-dependent failure explicit and stable for both human review and automated tooling.

## Storage/publication escape classification

Preview.10 distinguishes **effects on pointed-to memory** from **publishing the authority value**. A declared store such as `out[0] = 7;` contributes to `writes out`. Encoding a capability-derived pointer and storing that value, directly or through admitted provenance, is rejected as:

```text
code=1513 reason=effect-storage-escape-unverified reason_id=6513
expected=non-publishing-capability-storage-or-future-explicit-transfer-contract
```

The classification is representation-independent. A cast before return is still a return escape and maps to `1512/6512`. No ownership or authority transfer contract is admitted in Preview.10.

## Structured escape-event records

Preview.11 publishes semantic index kind `15` before fail-closed escape diagnostics. Fields are `packed_shape`, capability-root ordinal, local ordinal, source start, source count and version. `packed_shape` encodes channel (return/storage/unverified-call), provenance (direct/alias/transformed) and transport (pointer/integer-cast/call-argument). This record is evidence only and never authorizes transfer.

## Preview.12 authority-root state

Semantic index kind `16` gives every declared capability root a verified state record: function, root ordinal, `ACTIVE` state, generation `0`, source span and version. Alias chains and transformed provenance resolve back to this root; they do not create new authority. Preview.12 intentionally has no positive transfer transition. A future transfer must prove source, destination and post-transfer source invalidation before syntax is admitted.

## Preview.13 post-transfer source invalidation

Preview.13 does not add a `transfer` keyword or any public transfer intrinsic. It adds the internal state-machine primitive needed before syntax can be considered. Kind `16` now admits `ACTIVE=1` and `TRANSFERRED=2`. An internal transition consumes an ACTIVE source root, emits `TRANSFERRED(source)` and `ACTIVE(destination)` at `generation + 1`, and refuses to reuse a transferred source as a transfer origin.

The effect verifier now resolves each direct, aliased, or transformed capability use to its authority root and requires that root to be ACTIVE at the exact source position. A post-transfer source use therefore fails closed as `1514/6514 authority-source-transferred`.

## Preview.14 destination authority binding

Preview.14 adds no source keyword. It extends the semantic foundation with index kind `17`, which binds a new ACTIVE authority generation to an **ordinary local pointer identity** already connected to the original capability by admitted provenance.

The state model is:

```text
capability root = permission/provenance root
kind 16         = ACTIVE / TRANSFERRED state by authority identity and generation
kind 17         = destination-local -> original provenance root binding for a handoff generation
```

A positive internal handoff is admitted only when the source is the current ACTIVE owner, the destination is a previously declared pointer local, its provenance descends from that source, it has no prior authority state/binding, and exactly one ACTIVE identity exists for the original provenance before and after the event. Sibling-lineage jumps, reused destinations, malformed/cyclic provenance and destinations outside the admitted declaration lifetime are rejected by the gate.

The ordinary effect verifier consumes the same result. In the Preview.14 verifier probe, `next[0]` after the handoff is accepted, while a later `data[0]` use of the old source is rejected with:

```text
code=1514 reason=authority-source-transferred reason_id=6514
```

with no output publication.

The production compiler intentionally contains no unbound positive transition helper. There is still no `transfer` keyword or public intrinsic. Return/storage/call transfer channels and general lifetime analysis remain outside the public language contract.
