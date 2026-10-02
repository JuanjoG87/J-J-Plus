# Contributing to J/J+ Public Review

Public Review 0.1 is primarily a design and implementation review.

Useful reports include ambiguous syntax, code that is hard for a human reviewer to understand, diagnostics that lack actionable information, unstable or redundant semantic structure, target-dependent semantics, and reproduction failures.

When proposing a language feature, please describe both the human-facing intent and the machine-verifiable semantic relationship. A source annotation that the compiler cannot verify should not be treated as a language guarantee.

Please include a minimal J/J+ reproducer and the compiler lineage/hash when reporting compiler behavior.
