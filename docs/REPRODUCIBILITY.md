# Reproducibility

Run commands from the repository root on Linux x86-64 (WSL2 is suitable for the hosted bootstrap route).

## Fixed-point compilers

Root:

```sh
bootstrap/linux_x86_64/jjc-root spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt root-g2.o
./root-g2.o spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt root-g3.o
cmp root-g2.o root-g3.o
```

Expected SHA-256:

`377a6990533d7a47020c3a149ba23eae3901c555913306abb26640329c6eecb3`

Profile B:

```sh
bootstrap/linux_x86_64/jjc-profile spec/PUBLIC_REVIEW_0_1_PROFILE_BUILD.txt profile-g2.o
./profile-g2.o spec/PUBLIC_REVIEW_0_1_PROFILE_BUILD.txt profile-g3.o
cmp profile-g2.o profile-g3.o
```

Expected SHA-256:

`6c58f2dad44c2b6790945958ae055fececc122abcc78348af62da8316558886f`

Diagnostic:

```sh
bootstrap/linux_x86_64/jjc-diagnostic spec/PUBLIC_REVIEW_0_1_DIAGNOSTIC_BUILD.txt diagnostic-g2.o
./diagnostic-g2.o spec/PUBLIC_REVIEW_0_1_DIAGNOSTIC_BUILD.txt diagnostic-g3.o
cmp diagnostic-g2.o diagnostic-g3.o
```

Expected SHA-256:

`4cec420e00517a6a27378bfeb818351b943ca041feb06e2f77bd7c9b39a3d2f9`

## Cross-lineage evidence

This candidate was also rebuilt as Root-from-Profile, Root-from-Diagnostic, Profile-from-Root and Diagnostic-from-Root. Each result was byte-exact with the corresponding fixed-point artifact.

## Target contract evidence

Expected object SHA-256 values:

- AArch64: `80327d782d9552c6e4ce114820bff993d2c412f97370be192f11e2a8e3ed2324`
- ARM32 `value != 0`: `25daeec9f5a0d832802908b800612f6ec4fc40a27bcb536f5e07c1c135a798ac`
- ARM32 `value == 0`: `4e3a02f6345deb07c5bcd51f52fcee6815e685826b6aeebf0572f26840659ce1`
- i386: `0f71f9ce24321b666b5fdf6f98fa1e0698720736ad5050a1fe4df9e155ed73d6`

The checked target artifacts are retained under `evidence/multitarget/`.

## Verified effect evidence

The bounded `capability` / `reads` / `writes` layer has these representative outputs:

- x86-64 direct read: `ffeddb59b7df6d7194843dd0940d179369cdb2c5da7e5f7c53872e7d066c9b5f`
- x86-64 direct write: `2d3fb8c5920df7648a3c7181d318f31e89d50e0fd551c4e972c43c5197af61ec`
- x86-64 read+write: `7d562827aeeaac0be7996fc3c110b39d3b9cb830af91fa9c010d80ed80d5b4d3`
- AArch64 contract-only: `fcc2a9f2165483296afbde34b1cbc71ce581a2bf2875a037c6e30dc7ba760503`
- ARM32 contract-only: `22eaf74ba1b7c4620fa84e4f02cfe7005ef2c5b3a4cd20fb45907b88aa5e606c`
- i386 contract-only: `e4ca19a1cad0d9af8d42ee87789d02e3b862c6792fe37393c763b0bab3e1b56e`
- AArch64 direct read: `30a3798911d1593dc633be3c730178a1d03295e0f0e0c6308f00299d00725111`
- i386 direct read: `6f35ca4ec79397df8578502af41c52b71e2278c5fdcdcac054bcbdff5daff979`

Nine negative effect contracts are rejected in Root, Profile B and Diagnostic with no output publication (27/27 fail-closed runs). ARM32 constant direct-read evidence now includes indices 0, 1, 3 and 31:

- index 0: `eedd123e84e297f085f7a3554bb57029d99e5b95ae741a8b234236cb2db49a93`
- index 1: `fa0ec6626603731791c143330ec54857ac6d65f7344d759c4623b47367298da6`
- index 3: `482685bbb0737c10966a936707474f424542fef08c2de75ce1c1cb12e9f16156`
- index 31: `4029722abc52aa94298a6d7ded35712842af5e16b3646fe46892ed493b966bf1`

Index 32 is a fail-closed target boundary (`1601/6601`) with no output publication.


## Interprocedural effect evidence

Direct read-through-callee objects are byte-exact across Root/Profile/Diagnostic:

- x86-64: `75449a1c197a7be082cd1d263cb7217e04a5f6bcb7ae7a085632ec27ea95c0f4`
- AArch64: `cd2507f3a7c6d44797f2539a4009aa77466b3010eceaeb211daf445730119f3c`
- ARM32: `eedd123e84e297f085f7a3554bb57029d99e5b95ae741a8b234236cb2db49a93`
- i386: `7dde2f4636dc803a055e24560bbf56312d7850b337039a754b6afa5cd7848c46`

The x86-64 write-through-callee executable is `2fe5ca0f12858ffb1af7cc356b3b95984c7e268a5ee59cd474e041cb512e74b3`; the three-level read chain is `d6098244b78d2ceda688cab1dfcdf3245f6be1f241e65ba61e70960663d35606`. Both execute with exit code `0`.

Negative interprocedural tests are reproduced across all three lineages: hidden callee read -> `1506`, hidden callee write -> `1507`, unverified callee -> `1509/6509`. Nine runs fail closed with zero output publication.

Evidence is retained under `evidence/interprocedural/`.

## Local alias provenance evidence

Preview.7 two-alias chain outputs are byte-exact across Root/Profile/Diagnostic:

- x86-64: `07968bbfb7bdaaa3d0e858876cb12741dfcea759011576a519246c5cd96270b8`
- AArch64: `7a6425a029d9c37dab452a8b15c6d5f013e059996fe386fdeb6e2e61f1e21c9c`
- ARM32: `eedd123e84e297f085f7a3554bb57029d99e5b95ae741a8b234236cb2db49a93`
- i386: `e8acd487d60822c04814e37a972ac4ca1b038daed2f5764361d1e176d9048113`

The x86-64 chain executable runs with exit code `0`. A 64-edge chain is admitted and byte-exact across all three lineages (`686c05144e8399fdbb95825036684ffd82825f3de76b8b7b75d30e5495901f0b`) and executes with exit code `0`. A 65-edge chain fails closed with `1510/6510`. Negative provenance tests reproduce across all three lineages: hidden read -> `1506/6506`, rebind -> `1510/6510`, depth 65 -> `1510/6510`, all with no output publication.

Evidence is retained under `evidence/alias_provenance/`.

## Transformed provenance evidence

Preview.8 admits `pointer + constant-byte-offset` provenance when the offset is aligned to 8 and lies in `0..248`. Positive `+8` and `+248` cases are byte-exact across Root/Profile/Diagnostic on all four targets. Invalid `+1`, `+256`, and dynamic-offset cases fail closed with `1511/6511` and publish no output.

- x86-64 `+8`: `9d676e92ad02e63f7dc2e290eb42c9d995b584ebc8fda783bbe31381f42e2463`
- AArch64 `+8`: `97aa015ce99f3e534cfdee9b8e52767f1e68f78324ce6321c1b22daac4d67350`
- ARM32 `+8`: `fa0ec6626603731791c143330ec54857ac6d65f7344d759c4623b47367298da6`
- i386 `+8`: `f6c37db8c8daa9627229c7f60b3a754ca5eb5a0961d473a0ea3f718be153fd8d`
- x86-64 `+248`: `7ae29602494cb6ad1337a4a51bffdbaf0aa7090cfe5d109b1dafd08318eb6f71`
- AArch64 `+248`: `9d11d23a80d94f5b243f584204eebeb26ec8eba89782d4f97d08aa930263b60f`
- ARM32 `+248`: `4029722abc52aa94298a6d7ded35712842af5e16b3646fe46892ed493b966bf1`
- i386 `+248`: `a573ce95a6f45d617f09c56f29575f121eb36b50976d58ebfaeff72d915e18ce`

ARM32 lowers the reviewed transform to CIR `ARG -> ADDRESS_OFFSET -> LOAD -> RETURN`; `+8` emits A32 `e1c000d8`, while `+248` emits `e1c00fd8`.


## Return-escape evidence

Preview.9 rejects three semantically equivalent escape forms across Root/Profile/Diagnostic: direct capability return, admitted local-alias return, and admitted transformed-provenance return. All 9 runs fail closed with `1512/6512`, publish no object, and retain source spans. Evidence is under `evidence/return_escape/`.

## Preview.10 storage/publication escape

Preview.10 rejects three semantically equivalent storage/publication forms across Root/Profile/Diagnostic: direct capability, admitted alias provenance and admitted transformed provenance encoded as `i64` and stored. All 9 runs fail closed with `1513/6513`, publish no object and retain source spans. `return data as i64` remains `1512/6512`. Evidence is under `evidence/storage_escape/`.

## Preview.11 structured escape-event evidence

Kind `15` is added to the semantic index and the public inspection API. Root/Profile/Diagnostic produce the same inspection API object (`92d1e0f1dcfcab9118e25270fada69424e3cc60a24e3f94087d436135a5bc2a5`). Human diagnostics for unverified call, return escape and storage escape remain unchanged. Evidence is under `evidence/escape_event/`.

## Preview.12 authority-root state

Semantic index kind `16` gives every declared capability root a verified state record: function, root ordinal, `ACTIVE` state, generation `0`, source span and version. Alias chains and transformed provenance resolve back to this root; they do not create new authority. Preview.12 intentionally has no positive transfer transition. A future transfer must prove source, destination and post-transfer source invalidation before syntax is admitted.

## Preview.13 historical checkpoint

Preview.13 established post-transfer source invalidation and reserved `1514/6514`. Its synthetic positive-transition gates are **not shipped as executable testing code in Preview.14**, because their unbound destination model is superseded by the stricter bound transition below. The historical result remains documented in the changelog and release history.

## Preview.14 destination-binding gates

Two J/J+ gates are retained; neither appears in a production build manifest.

1. `PREVIEW14_DESTINATION_BINDING_GATE_BUILD.txt` replaces only the parse/finalize runtime with `preview14_destination_binding_gate_runtime.j`. It proves `root g0 -> local g1 -> local g2`, exactly one ACTIVE authority for the original provenance at every generation, alias resolution to the current owner, and fail-closed rejection of destination reuse, sibling-lineage jumps, malformed/cyclic provenance and a destination declared after the event. Final gate compiler SHA-256: `9a071aaa13303796794af56c9b6da9d84fa2cd96f1732a03364fcd960d19024c`. It emits `HELLO_BUILD` byte-identically to production: `eec353afe4842b433ed17798be1a78eff20049e78a6f924ebf5c16eb0917403b`, runtime exit `0`.

2. `PREVIEW14_DESTINATION_BINDING_VERIFIER_GATE_BUILD.txt` replaces only `semantic_statement_build.j` with the test-only verifier variant for `p14probe`. The gate binds root `data` to ordinary local `next` at the internal event. The subsequent `next[0]` use is accepted; the later old-source `data[0]` use fails closed with `rc=113`, `code=1514`, `reason_id=6514`, `reason=authority-source-transferred`, at source offset `142`, line `8`, column `20`, and publishes no output. Final gate compiler SHA-256: `d59426cb02f3c4a55ec594e0839eef5f2d96e104d75f7be10ed66cd25120ec8d`. The production compiler accepts the same probe and emits SHA-256 `1d6b3b5fe6c9cfbbe2c2706b45ad3d70a688e99da518739de3ffe3575330f091`.

The public semantic inspection API including kind `17` is byte-exact across Root/Profile/Diagnostic with SHA-256 `012876cc60b221df65d431bab8ee5b4e38843365d453ca7d4f9e501fab1aa7d3`. No public `transfer` keyword or intrinsic exists in Preview.14.
