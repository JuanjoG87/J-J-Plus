# Alias provenance evidence — Preview.7

Preview.7 admits bounded acyclic chains of ordinary local pointer aliases without adding source syntax. Each alias is single-assignment and records immediate provenance in semantic index kind `12`, version `1`. The verifier follows strictly decreasing local ordinals until it reaches a declared capability parameter; this makes cycles unrepresentable in the admitted relation.

Example:

```j
var a:*i64 = data;
var b:*i64 = a;
return leaf(b);
```

Effects through `b` are attributed to the same capability root `data`. The public bound is 64 alias edges. Depth 64 is admitted and executes on x86-64; depth 65 fails closed with `1510/6510 effect-alias-unverified`. Rebinding also fails with `1510/6510`; hiding a propagated read fails with `1506/6506`.

Positive chain outputs are byte-exact across Root/Profile/Diagnostic:
- x86-64: `07968bbfb7bdaaa3d0e858876cb12741dfcea759011576a519246c5cd96270b8`
- AArch64: `7a6425a029d9c37dab452a8b15c6d5f013e059996fe386fdeb6e2e61f1e21c9c`
- ARM32: `eedd123e84e297f085f7a3554bb57029d99e5b95ae741a8b234236cb2db49a93`
- i386: `e8acd487d60822c04814e37a972ac4ca1b038daed2f5764361d1e176d9048113`

ARM32 consumes the same provenance records through a bounded semantic accessor and normalizes the verified chain to its admitted direct `data[0]` load. This is not a claim of general ARM32 call ABI or general alias analysis.
