# Interprocedural effect evidence

Preview.8 preserves bounded effect requirements through direct internal calls. A caller may pass an admitted capability provenance relation to a previously defined callee whose pointer parameter has a verified effect contract. The callee contract is summarized in semantic index kind `11`, and required reads/writes become observed caller effects.

This is intentionally not general alias analysis. Locals, transformed pointer expressions, external calls, uncontracted callees and unsupported escape shapes remain fail-closed. ARM32 uses bounded semantic inlining for the reviewed direct wrapper shape rather than claiming a general call ABI.
