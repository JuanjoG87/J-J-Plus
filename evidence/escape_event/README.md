# Preview.11 structured escape-event evidence

Preview.11 adds semantic index kind `15` as structural evidence for fail-closed authority escapes. It does not add syntax and does not authorize transfer.

Kind 15 fields: packed shape, capability-root ordinal, local ordinal, source start, source count, version. Shape packs channel, provenance form and transport form.

Channels: return, storage/publication, unverified call. Provenance: direct capability, alias chain, transformed provenance. Transport: pointer value, integer cast, call argument.

Human-facing diagnostics remain 1509/1512/1513. The public semantic inspection API compiles byte-exact across Root/Profile/Diagnostic.
