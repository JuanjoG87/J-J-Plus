# Known Limitations

Public Review 0.1 is deliberately bounded. The compiler rejects unsupported semantics instead of inferring authority or effects.

- No frozen ABI, stable 1.0 specification, complete standard library or production-maturity claim.
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
