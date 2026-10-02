# Transformed provenance evidence

Preview.8 admits one transformed pointer-provenance form already present in J/J+: `pointer + constant-byte-offset`.

The constant is measured in bytes. The verifier requires alignment to 8, each admitted offset in `0..248`, a total transformed offset no greater than 248 bytes, and a provenance chain resolving to a declared capability root. Semantic kind 13 records the expression; kind 14 records the transformed alias edge. Dynamic, unaligned and out-of-range transforms fail closed with `1511/6511`.

Positive `+8` and `+248` objects are byte-exact across Root/Profile/Diagnostic on x86-64, AArch64, ARM32 and i386. ARM32 lowers the verified relation to CIR `ARG -> ADDRESS_OFFSET -> LOAD -> RETURN`; no general pointer-arithmetic or call-ABI claim is made.

The public semantic inspection module exposes kind-13 and kind-14 fields through named accessors. Root/Profile/Diagnostic compile that module byte-exactly to SHA-256 `a35195fcdcfc4526b596cc0c801cf52c97ecb6237f7bdbd1098338c6702d214a`.
