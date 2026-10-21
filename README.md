# imping

A Rust modding suite. It turns a Ghidra analysis of a program into typed Rust bindings that mods call and hook.

This repository gathers the components as git submodules, so one clone gets them all:

```sh
git clone --recursive https://github.com/WoefulWolf/imping
```

| Repository | What it is |
| --- | --- |
| [imping-hook](https://github.com/WoefulWolf/imping-hook) | In-process function hooking: typed detours and code injection. |
| [imping-ir](https://github.com/WoefulWolf/imping-ir) | The intermediate representation (IR) types and JSON Schema. |
| [imping-codegen](https://github.com/WoefulWolf/imping-codegen) | Rust bindings from IR, plus `imping-build` for build scripts and the `imping` CLI. |
| [imping-runtime](https://github.com/WoefulWolf/imping-runtime) | What generated bindings call into: module identity checks, globals and hooks. |
| [imping-ghidra](https://github.com/WoefulWolf/imping-ghidra) | A Ghidra script that exports a program as IR. |

Each component builds and is versioned on its own, and fetches the others it needs from GitHub. Inside this checkout, `.cargo/config.toml` points them at the local submodules instead, so a change in one is picked up by the others without pushing.

API docs for the Rust crates: https://woefulwolf.github.io/imping/. To build them locally, with links between the crates:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/docs.ps1 -Open
```

Status: early development, not published. Windows x64 only for now.

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE))
- MIT license ([LICENSE-MIT](LICENSE-MIT))

at your option.

AI assistance was used for parts of this project.
