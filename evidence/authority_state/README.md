# Preview.14 authority-state and destination-binding evidence

Semantic index kind `16` is the append-only authority-state ledger (`ACTIVE=1`, `TRANSFERRED=2`). Semantic index kind `17` binds a new ACTIVE generation to an ordinary destination local identity while preserving the original declared capability as the permission/provenance root.

The production compiler contains no unbound positive transition primitive. A positive internal handoff is admitted only through the bound path and must preserve exactly one ACTIVE authority lineage.

Evidence retained here covers:

- two independent capability roots at entry, byte-exact across Root/Profile/Diagnostic;
- kind `16` + kind `17` structured inspection API, byte-exact across all three lineages;
- Preview.14 internal state-machine/binding gate (`root g0 -> local g1 -> local g2`), including destination/lifetime conflict rejection;
- Preview.14 real-verifier gate: bound destination use accepted, old source use rejected as `1514/6514`, no output publication;
- representative legacy negative diagnostics remaining fail-closed.

No public `transfer` keyword or intrinsic exists in this candidate.
