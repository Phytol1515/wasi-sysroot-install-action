# Install components from WASI SDK to enable stock Clang to compile standalone WASM32 binaries

This GitHub Action installs the `libclang_rt.builtins-wasm32.a` library and the `wasi-sysroot` folder from a [WebAssembly/wasi-sdk] release.

## Usage

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Install LLVM
        uses: KyleMayes/install-llvm-action@latest
        with:
          version: "18" # specify a version

      - name: Install WASI SDK components
        uses: Phytol1515/wasi-sysroot-install-action@latest
        with:
          wasi-sdk-version: "25" # (optional) specify a version, defaults to "latest"

      - name: Compile a source to a WASM32 binary
        run: |
          clang --target=wasm32-unknown-wasi --sysroot=$WASI_SYSROOT -o example.wasm example.c