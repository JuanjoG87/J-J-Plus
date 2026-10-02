# Preview.10 storage/publication escape evidence

Preview.10 distinguishes ordinary writes to pointed-to memory from publishing the capability value itself.

- `out[0] = 7;` remains a normal declared write.
- `out[0] = data as i64;`, the same operation through an admitted alias, and the same operation through admitted transformed provenance all fail closed with `1513/6513 effect-storage-escape-unverified`.
- `return data as i64;` is normalized to the existing `1512/6512` return-escape classification.
- No explicit authority transfer is admitted.
