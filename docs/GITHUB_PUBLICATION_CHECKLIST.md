# GitHub Publication Checklist — Public Review 0.1

Target release: `v0.1.0-preview.14`

Status: **READY for source-visible GitHub public review once the distributed ZIP reproduces this checklist from a clean extraction.**

Intended label: **J/J+ Public Review 0.1 — Preview.14**

## Technical release gate

A package is ready for public GitHub review only when all of these are PASS from a clean extraction:

- repository-wide checksum verification;
- packaged Root bootstrap rebuilds Root to the documented fixed point (`G2`);
- rebuilt Root rebuilds itself byte-exactly (`G2 = G3`);
- Profile B and Diagnostic documented fixed points are present and cross-lineage evidence is exact;
- `HELLO_BUILD` compiles and executes successfully;
- representative `require`, effect, alias and transformed-provenance regressions retain their sealed output hashes;
- AArch64, ARM32 and i386 reviewed target objects retain their sealed hashes;
- Preview.14 destination-binding state-machine gate passes;
- Preview.14 real-verifier gate accepts the bound destination use and rejects the dead source as `1514/6514` with no output publication;
- semantic inspection API for kind `17` is byte-exact across Root/Profile/Diagnostic;
- no obsolete synthetic Preview.13 transition implementation is shipped as executable test code.

## Repository hygiene gate

- no credentials, tokens, private keys or `.env` files;
- no host-specific `/home/...`, `/mnt/data/...` or user-profile paths in shipped text;
- no accidental build scratch files;
- `README.md`, `README.es.md`, `LICENSE`, `SECURITY.md`, `CONTRIBUTING.md`, `CHANGELOG.md` and `RELEASE_NOTES.md` are present;
- reproducibility instructions state the exact expected compiler hashes;
- a repository-wide `SHA256SUMS_ALL.txt` is included and verifies cleanly.

## Publication wording

The package may be described as:

> J/J+ Public Review 0.1 — Preview.14, an experimental source-visible compiler/language review candidate with reproducible self-host evidence.

Do **not** describe this candidate as:

- production-ready;
- ABI-frozen or J/J+ 1.0;
- a complete ownership/borrowing model;
- having public authority-transfer syntax;
- open source under the current OMEGA Research Source Notice.

## Licensing boundary

The current `LICENSE` grants the permissions stated by the OMEGA Research Source Notice and is intentionally retained. A later switch to an OSI-style license is a separate project decision and must not be implied by putting the repository on GitHub.
