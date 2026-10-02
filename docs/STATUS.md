# Public Review 0.1 Status

State: **CANDIDATE / GITHUB SOURCE-VISIBLE PUBLIC-REVIEW READY / NOT CURRENT / NOT PRODUCTION-READY**.

Candidate build: `v0.1.0-preview.14`.

## Closed in this candidate

- Human-AI `require <condition> else return <expression>;` syntax and structured diagnostics.
- Verified bounded `capability` / `reads` / `writes` contracts.
- Bounded interprocedural effect propagation (semantic index kind `11`).
- Bounded acyclic local alias provenance up to 64 edges (kind `12`).
- Bounded transformed provenance for `pointer + constant-byte-offset` using kinds `13/14`, offsets `0..248`, aligned to 8.
- Fail-closed return, storage/publication and unverified-call escape classification plus structured escape events (kind `15`).
- Authority-state ledger (kind `16`) with append-only `ACTIVE` / `TRANSFERRED` generations and post-transfer source invalidation (`1514/6514`).
- Destination authority binding (kind `17`) to an ordinary local pointer identity with valid provenance to the original capability.
- Exactly one ACTIVE authority lineage is required before and after an internal handoff.
- Destination collision, sibling-lineage jumps, malformed/cyclic provenance and destinations outside the admitted declaration lifetime fail closed in the Preview.14 gate.
- The production compiler has no unbound positive transition primitive and exposes no `transfer` keyword or public transfer intrinsic.
- Root, Profile B and Diagnostic fixed points plus four exact cross-lineage rebuilds.
- Representative valid outputs remain byte-identical on x86-64, AArch64, ARM32 and i386 when no authority handoff occurs.

## Fixed points

- Root: `377a6990533d7a47020c3a149ba23eae3901c555913306abb26640329c6eecb3`
- Profile B: `6c58f2dad44c2b6790945958ae055fececc122abcc78348af62da8316558886f`
- Diagnostic: `4cec420e00517a6a27378bfeb818351b943ca041feb06e2f77bd7c9b39a3d2f9`

Each lineage has `G2 = G3` byte-exact. Four cross-lineage rebuilds are exact.

## Preview.14 authority-binding checkpoint

Kind `16` remains the state ledger. Kind `17` records the binding between the new ACTIVE generation and a real destination local identity. Permission/provenance remains rooted in the original declared capability; active authority moves to one bound local identity.

The internal state-machine gate proves:

```text
root ACTIVE g0
  -> local next ACTIVE g1 / root TRANSFERRED g1
  -> local next2 ACTIVE g2 / next TRANSFERRED g2
```

with exactly one ACTIVE lineage at each generation. The real-verifier gate accepts `next[0]` after the handoff and then rejects the old `data[0]` source with `1514/6514`, publishing no output.

## Still intentionally outside the public language contract

- Public `transfer` syntax or intrinsic.
- Return/storage/call channels that carry transferred authority.
- General lifetime/escape analysis.
- Alias rebinding and provenance depth above 64.
- Dynamic, subtractive, unaligned or >248-byte transformed pointer provenance.
- External-call effect contracts.
- General ARM32 call ABI and dynamic pointer indexing.
- Verified `ensures` and `invariant`.
- Final ownership/borrowing surface syntax.
- Frozen ABI or production-stability guarantee.
- An OSI-style open-source license; the current package remains source-visible under the OMEGA Research Source Notice.
