# Bootstrap Trust Boundary

[Español](BOOTSTRAP_TRUST.es.md)

Public Review 0.1 is reproducible **from the bootstrap binaries committed in this repository**. That is an important property, but it is not the same as proving the semantic correctness or independent origin of those binaries.

## Public trust boundary

The public hosted bootstrap route begins with:

```text
bootstrap/linux_x86_64/jjc-root
bootstrap/linux_x86_64/jjc-profile
bootstrap/linux_x86_64/jjc-diagnostic
```

Their hashes are recorded in:

```text
bootstrap/linux_x86_64/SHA256SUMS.txt
```

From those seeds, the repository demonstrates:

- each compiler lineage rebuilds to its documented fixed point;
- G2 and G3 are byte-identical within each lineage;
- cross-lineage rebuilds converge to the expected target lineage;
- representative positive and negative language gates reproduce;
- checked multi-target outputs reproduce.

## What a fixed point proves

If:

```text
seed -> G2 -> G3
```

and:

```text
G2 == G3
```

byte-for-byte, the compiler has reached a reproducible fixed point for that source and build description.

This is evidence of **determinism and self-consistency**.

It does **not** by itself prove:

- that the compiler implements the intended language semantics correctly;
- that the initial bootstrap binary was produced by a trustworthy compiler;
- that the bootstrap binary is free of a trusting-trust style compromise;
- that the source is formally verified.

## Historical origin

The current public repository does not contain a complete independently reproducible chain that rebuilds the first hosted bootstrap binary from a smaller external seed.

The three checked-in bootstrap binaries were produced by the pre-publication J/J+ development lineage. Public Review 0.1 intentionally starts at those binaries and makes that trust boundary explicit rather than presenting the fixed point as a proof of bootstrap purity.

## Why three lineages help

Root, Profile B, and Diagnostic are used as divergence pressure. Cross-lineage rebuilding can expose accidental dependence on one lineage's implementation details.

This strengthens reproducibility evidence, but it still does not remove the initial-seed trust boundary.

## What would reduce that boundary further

Useful future work includes:

- preserving a documented smaller bootstrap stage;
- independently reproducing a bootstrap binary from a separately implemented path;
- diverse-double-compilation style checks where practical;
- external reproduction by independent reviewers;
- publishing a complete provenance record for future bootstrap transitions.

Until one of those stronger paths is published, the correct claim is:

> J/J+ Public Review 0.1 is reproducible from the published bootstrap seeds; it does not claim a seed-free or formally verified bootstrap chain.
