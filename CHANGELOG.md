## v0.1.0-preview.14

- Add semantic index kind 17 to bind a new ACTIVE authority generation to a verified ordinary local pointer identity.
- Require exactly one ACTIVE authority lineage for the original capability provenance before and after each internal handoff.
- Reject destination reuse, sibling-lineage jumps, malformed/cycle-like provenance and destinations outside the admitted declaration lifetime in the Preview.14 state-machine gate.
- Prove through the ordinary effect verifier that the bound destination remains usable while the old source fails closed with `1514/6514`, with zero output publication.
- Keep the production language free of a public `transfer` keyword/intrinsic and free of an unbound positive transition primitive.
- Close Root/Profile B/Diagnostic G2=G3 and four byte-exact cross-lineage rebuilds.
- Preserve representative Preview.13 x86-64/AArch64/ARM32/i386 outputs byte-for-byte when no authority handoff occurs.

## v0.1.0-preview.13

- Add internal kind-16 `ACTIVE -> TRANSFERRED` authority transitions without public transfer syntax.
- Require every verified capability use to observe an ACTIVE root after direct/alias/transformed provenance resolution.
- Add fail-closed `1514/6514 authority-source-transferred` for post-transfer source use.
- Add test-only transition and real-verifier gates proving generations 0 -> 1 -> 2, dead-source reuse rejection, exact use-span diagnostics and zero output publication.
- Close Root/Profile/Diagnostic G2=G3 and four byte-exact cross-lineage rebuilds.
- Preserve representative Preview.12 x86-64/AArch64/ARM32/i386 user outputs byte-for-byte.

## v0.1.0-preview.12

- Add semantic index kind 16 authority-root state ledger.
- Enforce one ACTIVE generation-0 record per declared capability root.
- Add public inspection accessors for authority state.
- Preserve aliases/transforms as provenance only; they never create authority.
- No positive transfer syntax or state transition admitted.

# Changelog

## Preview.11

- Adds structured escape-event semantic index kind `15` for fail-closed return, storage/publication and unverified-call escapes.
- Keeps human diagnostics 1509/1512/1513 unchanged while exposing the same intent structurally for compiler passes and agents.
- Adds public semantic inspection accessors for kind `15`.
- Does not admit authority/ownership transfer.
- Root/Profile/Diagnostic fixed points and four cross-lineage rebuilds are byte-exact.
- Representative Preview.10 valid outputs remain byte-identical.

## Preview.10

- Classifies publication of capability-derived values through storage uniformly as `1513/6513 effect-storage-escape-unverified`.
- Preserves ordinary declared pointee writes as effects rather than escapes.
- Normalizes `return <capability> as i64` to the existing `1512/6512` return-escape category.
- Keeps authority transfer fail-closed; no new source syntax.
- Root/Profile/Diagnostic fixed points and four cross-lineage rebuilds are byte-exact.
- Representative Preview.9 valid outputs remain byte-identical.

## Preview.9

- Classifies capability-derived pointer escape through `return` uniformly as `1512/6512 effect-return-escape-unverified`.
- Unifies direct capability, local-alias and transformed-alias return failures by semantic intent rather than representation.
- Keeps transfer fail-closed: no ownership/authority transfer syntax or runtime behavior is admitted.
- Closes Root/Profile/Diagnostic fixed points and four exact cross-lineage rebuilds.
- Retains byte-exact Preview.8 outputs for representative valid programs and reviewed targets.

## Preview.8

- Adds bounded transformed pointer provenance without new source syntax: `var shifted:*i64 = data + constant_bytes;`.
- Adds semantic index kind `13` for pointer-plus-constant expression summaries and kind `14` for transformed alias provenance.
- Admits constant byte offsets `0..248`, aligned to 8, with accumulated transformed provenance also bounded to 248 bytes.
- Adds `1511/6511 effect-pointer-transform-unverified` for dynamic, unaligned, out-of-range or otherwise unsupported transforms.
- Extends ARM32 bounded normalization to consume verified kind `13/14` records and emit CIR `ADDRESS_OFFSET`; `+8` emits `e1c000d8`, `+248` emits `e1c00fd8`.
- Closes Root/Profile/Diagnostic fixed points, four exact cross-lineage rebuilds and byte-exact `+8/+248` outputs on x86-64/AArch64/ARM32/i386.
- Preserves representative Preview.7 outputs byte-for-byte.

## Preview.7

- Extended semantic index kind `12` provenance from one local alias to acyclic single-assignment alias chains rooted at a capability parameter.
- Added strict source-ordinal descent and a public 64-edge provenance bound; depth 65 fails with `1510/6510`.
- Generalized ARM32 bounded normalization to consume semantic provenance edges through `jj_core_effect_alias_field`; a verified alias chain normalizes to the same admitted direct `data[0]` load.
- Updated `1510` expectation to `acyclic-single-assignment-local-pointer-alias-chain-to-capability-root`.
- Closed Root/Profile/Diagnostic fixed points and four cross-lineage rebuilds; chain outputs are byte-exact on x86-64/AArch64/ARM32/i386.
- Preserved representative Preview.6 artifacts byte-for-byte.


## Public Review 0.1 candidate

- Adds executable `require <condition> else return <expression>;` contracts.
- Reserves typed statement kind 13 for `require`; retains block/root kinds 11/12.
- Adds Human-AI semantic names and a machine-readable semantic ID registry.
- Adds structured diagnostics for require failures.
- Preserves legacy x86-64 outputs for the selected regression corpus.
- Closes Root/Profile B/Diagnostic fixed points and cross-lineage rebuilds.
- Demonstrates byte-exact contract output across x86-64, AArch64, ARM32 and i386.
- Extends bounded ARM32 source lowering with semantic zero-comparison CFG normalization rather than keyword-specific lowering.
- Adds verified bounded `capability`, `reads` and `writes` contracts for direct indexed pointer-parameter effects.
- Adds fail-closed effect diagnostics 1501/1503-1508 and semantic contract record kind 10.
- Adds structured inspection of declared and observed effect masks for tools/agents.
- Generalizes CIR constant-return classification for unused single arguments and preserves prior `require` target bytes.
- Closes ARM32 zero-index direct `*i64` reads using semantic CIR `ARG -> LOAD -> RETURN` and real A32 `LDRD` emission.
- Continues to defer `ensures`, `invariant`, general aliasing and broad/transformed interprocedural propagation.

## Preview.4

- Generalizes ARM32 direct `*i64` reads to constant indices 0..31 through CIR `ADDRESS_OFFSET`.
- Adds fail-closed `1601/6601` for ARM32 direct-load indices outside the admitted range.
- Activates `1502/6502 effect-contract-order` while preserving `1501/6501` for genuinely incomplete contracts.
- Preserves all previously sealed effect and `require` output hashes.


## Preview.5

- Adds bounded interprocedural effect propagation for direct internal calls forwarding a caller capability parameter to a contracted callee.
- Adds semantic call-summary index kind 11 and structured inspection API fields.
- Propagates callee read/write requirements into caller observed effects; underdeclared callers fail with 1506/1507.
- Adds `1509/6509 effect-call-unverified` for direct capability delegation to an unverifiable callee.
- Demonstrates a three-level read chain and direct write propagation on x86-64.
- Demonstrates byte-exact direct-call read evidence across Root/Profile/Diagnostic on x86-64, AArch64, ARM32 and i386.
- ARM32 uses bounded semantic direct-call inlining into the already admitted direct-load shape; no general ARM32 call ABI is claimed.
- Preserves all sealed Preview.4 effect and `require` output hashes.

## Preview.6

- Added bounded local pointer alias provenance without new source syntax.
- Added semantic index kind `12`, version `1`, linking a single-assignment local pointer alias to its originating capability parameter.
- Effects through the admitted alias are attributed to the original capability parameter and propagate through contracted internal calls.
- Added `1510/6510 effect-alias-unverified` for rebinding and unsupported alias chains.
- Closed byte-exact Root/Profile/Diagnostic target evidence for the admitted alias on x86-64, AArch64, ARM32 and i386.
- ARM32 normalizes the admitted alias+wrapper shape to the existing direct-load CIR; no general ARM32 call ABI or alias analysis is claimed.
- Preview.5 representative outputs remain byte-identical.
