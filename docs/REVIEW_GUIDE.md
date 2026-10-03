# Public Review Guide

## Review status terminology

Public Review 0.1 is an invitation to external scrutiny. It is not a claim that the project has already received independent peer review.

Use these terms precisely:

- `gated` / `validated`: passed documented project checks;
- `internally audited`: inspected through the project's creator/rival process;
- `externally reproduced`: independently reproduced by a third party;
- `externally reviewed`: attributable to an identifiable independent reviewer.

See [EXTERNAL_REVIEW_STATUS.md](EXTERNAL_REVIEW_STATUS.md).

A useful external review should try to falsify a concrete invariant, not merely confirm that hashes match. Two starting points are [WHAT_JJPLUS_PREVENTS.md](WHAT_JJPLUS_PREVENTS.md) and [BOOTSTRAP_TRUST.md](BOOTSTRAP_TRUST.md).

The goal of Review 0.1 is not to ask whether J/J+ has every feature expected of a mature language. The useful question is whether its emerging Human-AI contract is understandable, deterministic and verifiable.

For human review, try reading `examples/guarded.j` before reading compiler internals. Record anything whose behavior you had to guess. Then inspect the matching diagnostics and `spec/JJP_HUMAN_AI_SEMANTIC_IDS_V1.json` and check whether they clarify the same semantics rather than creating a second interpretation.

For tool/agent review, consume stable identities and source locations directly. Do not treat comments or prose documentation as semantic authority when compiler structure provides an explicit identity.

Especially useful findings are cases where a human-readable construct cannot be represented deterministically, or where structured metadata is precise but source code obscures intent. Those are convergence failures and should be treated as language-design bugs.

For effect review, compare a positive direct-read example with the negative `undeclared_read`, `undeclared_write`, `outside_capability`, `scalar_capability`, `duplicate_target` and `capability_escape` tests. The important property is that readable declarations and machine-observed effects cannot disagree silently.

For grammar review, compare `incomplete_contract` with `order_reads_before_capability`: they intentionally produce different stable diagnostics (`1501` versus `1502`). For target-boundary review, compare ARM32 index 31 with index 32; the former publishes code while the latter fails with `1601/6601` without pretending the source contract itself is invalid.


For interprocedural review, compare `tests/effects/interprocedural/read_through_callee.j` with `undeclared_callee_read.j` and `unverified_callee.j`. The key property is that a readable callee contract becomes a structured caller-observed effect rather than an unchecked promise. Also inspect semantic index kind `11` through the inspection API; it should describe the same relation without creating an AI-only semantics.
