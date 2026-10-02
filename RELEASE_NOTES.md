# J/J+ v0.1.0-preview.14 — Public Review 0.1 Candidate

Preview.14 closes **destination authority binding and exactly-one-ACTIVE-lineage verification** without adding public transfer syntax. Semantic kind `16` remains the append-only authority-state ledger; kind `17` binds each new ACTIVE generation to an ordinary local pointer identity whose provenance is already verified against the original capability.

The state-machine gate proves `root g0 -> local g1 -> local g2` while preserving exactly one ACTIVE authority lineage. Destination reuse, sibling-lineage jumps, malformed/cycle-like provenance and destinations outside the admitted declaration lifetime fail closed. A separate real-verifier gate accepts use of the bound destination and then rejects a later use of the old source with `1514/6514 authority-source-transferred`, publishing no output. The production compiler still exposes no `transfer` keyword, transfer intrinsic or unbound positive transition primitive.

Final fixed points are Root `377a6990533d7a47020c3a149ba23eae3901c555913306abb26640329c6eecb3`, Profile B `6c58f2dad44c2b6790945958ae055fececc122abcc78348af62da8316558886f`, and Diagnostic `4cec420e00517a6a27378bfeb818351b943ca041feb06e2f77bd7c9b39a3d2f9`. Each closes G2=G3 byte-exactly and all four cross-lineage rebuilds are exact. Representative x86-64, AArch64, ARM32 and i386 outputs from Preview.13 remain byte-identical when no authority handoff occurs.

This candidate is intended for **source-visible GitHub public review** under the OMEGA Research Source Notice. It is not an open-source license, a frozen ABI, or a production-ready release.

# J/J+ v0.1.0-preview.13 — Public Review Candidate

Preview.13 adds **post-transfer source invalidation infrastructure without public transfer syntax**. Kind `16` now supports `ACTIVE` and `TRANSFERRED` states. The internal transition primitive atomically records `TRANSFERRED(source)` and `ACTIVE(destination)` at the next generation. The effect verifier consults the authority ledger at every capability use after direct/alias/transformed provenance has resolved to its root. A source root that is no longer ACTIVE fails closed as `1514/6514 authority-source-transferred`.

A dedicated J/J+ runtime gate exercises generation 0 → 1 → 2 transitions, proves use-before-transition remains ACTIVE, post-transition source use is rejected, repeated transfer from a dead source is rejected, and the destination can become the source of a later transfer. No `transfer` keyword or public intrinsic is present.

Final fixed points are Root `3c8e211c1574f816ab933959c181a0e65e8d454bebf56afe278bc9c86634caee`, Profile B `bb04304466703b04d3348552099d6a30da483c572b90bfa77b06aebcc3faa261`, and Diagnostic `b8904cf3be9ffb01e11f54fbf61fa9c02bfd227fcb5cd6ba40f370ca24e06809`; all close G2=G3 and all four cross-lineage rebuilds are byte-exact. A second test-only verifier gate forces a transfer immediately before the ordinary effect verifier and proves the actual source use fails with `1514/6514`, no output publication. Preview.12 representative x86-64 and AArch64/ARM32/i386 objects remain byte-identical.

# J/J+ v0.1.0-preview.12 — Public Review Candidate

Preview.12 adds a verified authority-root state ledger without adding source syntax. Each declared capability publishes exactly one semantic index kind `16` record with `ACTIVE`, generation `0`. Aliases and pointer transforms retain the same root and do not create authority. No positive authority transfer is admitted yet.

Gates: Root/Profile/Diagnostic G2=G3, four cross-lineage rebuilds exact, two-root ledger program byte-exact across three lineages, kind-16 inspection API byte-exact, Preview.11 representative outputs and AArch64/ARM32/i386 transform outputs unchanged.

# J/J+ v0.1.0-preview.11 — Public Review Candidate

Preview.11 adds **structured escape-event evidence** without adding source syntax or admitting authority transfer.

Semantic index kind `15`, version `1`, records fail-closed return, storage/publication and unverified-call escape events. The packed shape identifies escape channel, provenance form and transport form; the remaining fields retain capability-root ordinal, local ordinal and source span.

Human diagnostics remain unchanged (`1509/6509`, `1512/6512`, `1513/6513`). The public semantic inspection API builds byte-exact across Root/Profile/Diagnostic.

Fixed points:
- Root: `a61fa90adb765f20ac93012f8c9182b76bcb3ed66914967ffbb857d3e9a8b380`
- Profile B: `b10fc3cc0a301b44210ad90150d066a4f9fe1a657dc3f14c033789fe26591796`
- Diagnostic: `c3e485dbfc2292380ba0b5300529fa08947c570ce3e54d29a816625c4a53cd54`

All three lineages have G2=G3 byte-exact; all four cross-lineage rebuilds are exact; representative Preview.10 outputs are byte-identical.
