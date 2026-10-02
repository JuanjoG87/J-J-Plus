# Review Roadmap

## Public Review 0.1 — current boundary

Preview.14 closes destination authority identity and uniqueness without exposing transfer syntax. Kind `16` is the authority-state ledger and kind `17` binds a new ACTIVE generation to an ordinary local pointer identity whose provenance is already verified. The production compiler contains no unbound positive transfer primitive.

## Next language layer

1. Integrate bound authority handoff with the existing structured escape channels so return, storage/publication and selected internal calls can be reasoned about without creating a second authority.
2. Prove lifetime/end-of-scope behavior for a bound destination, including fail-closed behavior when authority would outlive the admitted owner.
3. Only after those gates close, design a public `transfer` surface form. The syntax must map to the already-proven state/binding machinery rather than create new semantics.
4. Add effect contracts for selected external calls without importing foreign authority.
5. Extend ARM32 pointer-memory lowering beyond constant indices `0..31` and keep that work separate from any general call-ABI claim.
6. Build verified `ensures` and `invariant` on the same contract machinery.
7. Generalize ownership/borrowing syntax only where the verifier can prove the claimed authority relation.

No roadmap item is part of the language contract until it has executable positive/negative tests, structured evidence and reproducible gates.

## Publication roadmap

Preview.14 is intended to be the first package assessed against a GitHub **source-visible public review** checklist. Publishing it does not freeze the ABI, declare production readiness or change the current license into an open-source license.
