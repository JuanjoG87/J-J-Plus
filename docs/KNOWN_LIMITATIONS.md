# Known Limitations

Public Review 0.1 is deliberately bounded. The compiler rejects unsupported semantics instead of inferring authority or effects.

- No frozen ABI, stable 1.0 specification, complete standard library or production-maturity claim.
- The public self-host/reproducibility chain starts from checked-in Linux x86-64 bootstrap binaries. Their complete pre-publication origin is not independently reproducible from this repository alone; fixed-point equality demonstrates determinism/self-consistency from those seeds, not semantic correctness or seed-free trust. See `docs/BOOTSTRAP_TRUST.md`.
- No independent external reviewer is currently claimed as having validated the full compiler or authority model. “Public Review” is the publication phase, not a peer-review claim. See `docs/EXTERNAL_REVIEW_STATUS.md`.
- The public examples are intentionally small. The repository does not yet provide a non-trivial end-to-end showcase program combining the authority/effect/provenance features.
- The Human-AI direction currently demonstrates a shared structured semantic inspection surface. It does not yet demonstrate a complete external agent workflow or prove a productivity advantage over mature language tooling. See `docs/HUMAN_AI_SEMANTICS_DEMO.md`.
- Public authority transfer syntax is not admitted. Preview.14 proves internal destination binding and one-ACTIVE-lineage invariants only.
- Return, storage/publication and call escapes cannot yet carry transferred authority; they remain fail-closed unless already admitted as ordinary effects.
- General lifetime/escape analysis is not implemented.
- Alias provenance is single-assignment, acyclic and bounded to 64 edges; rebinding and deeper chains fail closed.
- Pointer-transform provenance is limited to `pointer + constant-byte-offset`, aligned to 8, with offsets and accumulated displacement in `0..248`.
- Dynamic/subtractive/unbounded pointer transforms are not admitted.
- External-call effect contracts are not admitted.
- ARM32 direct `*i64` indexing is bounded to constant indices `0..31`; no general ARM32 call ABI is claimed by the reviewed wrapper normalization.
- `ensures`, `invariant` and a final ownership/borrowing surface remain future language work.
- The current OMEGA Research Source Notice is source-visible but not an OSI-style open-source license.

The Preview.14 package may be reviewed publicly as an experimental source-visible candidate, but that publication should not be described as an open-source or production-ready release.
