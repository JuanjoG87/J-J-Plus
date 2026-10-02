# J/J+ Quick Start

[Español](#inicio-rápido-en-español)

This guide uses the reviewed **Linux x86-64 hosted bootstrap route** from Public Review 0.1. WSL2 is suitable for this route.

## 1. Clone the repository

```bash
git clone https://github.com/MinOSPlus/J-J-Plus.git
cd J-J-Plus
```

## 2. Verify the reviewed bootstrap compilers

```bash
(cd bootstrap/linux_x86_64 && sha256sum -c SHA256SUMS.txt)
chmod +x bootstrap/linux_x86_64/jjc-root
```

Expected bootstrap hashes are recorded in the repository. The Root compiler hash is:

```text
377a6990533d7a47020c3a149ba23eae3901c555913306abb26640329c6eecb3
```

## 3. Compile and run your first J/J+ program

```bash
bootstrap/linux_x86_64/jjc-root examples/HELLO_BUILD.txt hello.o
sha256sum hello.o
chmod +x hello.o
./hello.o
echo $?
```

Expected object SHA-256:

```text
eec353afe4842b433ed17798be1a78eff20049e78a6f924ebf5c16eb0917403b
```

Expected runtime exit code:

```text
0
```

The build manifest points at the real source file `examples/hello.j`.

## 4. Compile reviewed language examples

A `require` example:

```bash
bootstrap/linux_x86_64/jjc-root examples/GUARDED_BUILD.txt guarded.o
sha256sum guarded.o
```

Expected SHA-256:

```text
3ac8f8b38196fba2b1169d445ad4df6ac58c0be70d02ca9d9d7a0d4cc300a411
```

A capability/effect-read example:

```bash
bootstrap/linux_x86_64/jjc-root examples/EFFECT_READ_BUILD.txt effect-read.o
sha256sum effect-read.o
```

Expected SHA-256:

```text
ffeddb59b7df6d7194843dd0940d179369cdb2c5da7e5f7c53872e7d066c9b5f
```

## 5. Rebuild the Root compiler to a fixed point

```bash
bootstrap/linux_x86_64/jjc-root \
  spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt \
  root-g2.o

chmod +x root-g2.o

./root-g2.o \
  spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt \
  root-g3.o

cmp root-g2.o root-g3.o
sha256sum root-g2.o root-g3.o
```

Both files should have SHA-256:

```text
377a6990533d7a47020c3a149ba23eae3901c555913306abb26640329c6eecb3
```

For the complete reviewed procedure, see [REPRODUCIBILITY.md](REPRODUCIBILITY.md).

## About GitHub's language statistics

J/J+ currently uses the `.j` extension. GitHub Linguist also associates `.j` with **JASS**, which caused this repository to be mislabeled.

The repository therefore marks J/J+ `.j` sources as non-detectable for GitHub's language statistics until J/J+ has an official Linguist definition. This changes only GitHub's presentation; it does not change or exclude the source files.

---

# Inicio rápido en español

Esta guía utiliza la ruta bootstrap alojada **Linux x86-64** revisada en Public Review 0.1. WSL2 sirve para esta ruta.

## 1. Clonar el repositorio

```bash
git clone https://github.com/MinOSPlus/J-J-Plus.git
cd J-J-Plus
```

## 2. Verificar los compiladores bootstrap revisados

```bash
(cd bootstrap/linux_x86_64 && sha256sum -c SHA256SUMS.txt)
chmod +x bootstrap/linux_x86_64/jjc-root
```

## 3. Compilar y ejecutar el primer programa J/J+

```bash
bootstrap/linux_x86_64/jjc-root examples/HELLO_BUILD.txt hello.o
sha256sum hello.o
chmod +x hello.o
./hello.o
echo $?
```

SHA-256 esperado:

```text
eec353afe4842b433ed17798be1a78eff20049e78a6f924ebf5c16eb0917403b
```

Código de salida esperado:

```text
0
```

## 4. Compilar ejemplos revisados

Ejemplo con `require`:

```bash
bootstrap/linux_x86_64/jjc-root examples/GUARDED_BUILD.txt guarded.o
sha256sum guarded.o
```

SHA-256 esperado:

```text
3ac8f8b38196fba2b1169d445ad4df6ac58c0be70d02ca9d9d7a0d4cc300a411
```

Ejemplo de capability/efectos:

```bash
bootstrap/linux_x86_64/jjc-root examples/EFFECT_READ_BUILD.txt effect-read.o
sha256sum effect-read.o
```

SHA-256 esperado:

```text
ffeddb59b7df6d7194843dd0940d179369cdb2c5da7e5f7c53872e7d066c9b5f
```

## 5. Reconstruir Root hasta el fixed point

```bash
bootstrap/linux_x86_64/jjc-root \
  spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt \
  root-g2.o

chmod +x root-g2.o

./root-g2.o \
  spec/PUBLIC_REVIEW_0_1_ROOT_BUILD.txt \
  root-g3.o

cmp root-g2.o root-g3.o
sha256sum root-g2.o root-g3.o
```

Ambos archivos deben producir:

```text
377a6990533d7a47020c3a149ba23eae3901c555913306abb26640329c6eecb3
```

Para la ruta completa revisada consulta [REPRODUCIBILITY.md](REPRODUCIBILITY.md).


## Clean generated files

The examples above write reviewed outputs into the repository working directory. They are build products, not source files:

```bash
rm -f hello.o guarded.o effect-read.o root-g2.o root-g3.o
```
