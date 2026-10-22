# imping

A Rust toolkit to patch and extend existing programs: typed bindings from a Ghidra analysis, plus hooks and code injection.

```sh
git clone --recursive https://github.com/WoefulWolf/imping
```

## Quick start

1. In Ghidra, name the functions and globals you want, then export the program with [imping-ghidra](https://github.com/WoefulWolf/imping-ghidra) to `target.ir.json`.
2. Generate bindings from it in your crate's build script:

   ```toml
   [dependencies]
   imping-runtime = { git = "https://github.com/WoefulWolf/imping-runtime" }

   [build-dependencies]
   imping-build = { git = "https://github.com/WoefulWolf/imping-codegen" }
   ```

   ```rust
   // build.rs
   fn main() -> Result<(), imping_build::Error> {
       imping_build::Builder::new("target.ir.json").generate()
   }
   ```

3. Call and hook the program from your code once it's loaded into the process:

   ```rust
   include!(concat!(env!("OUT_DIR"), "/imped.rs"));

   pub fn start() -> imping_runtime::Result<()> {
       unsafe { target::init() }?;
       let hook = target::SetVolume::hook(|original, level| {
           println!("volume set to {level}");
           original.forward()
       })?;
       hook.enable()?;
       hook.leak(); // keep it for the rest of the process
       Ok(())
   }
   ```

## Components

| Repository | What it is |
| --- | --- |
| [imping-hook](https://github.com/WoefulWolf/imping-hook) | In-process function hooking: typed detours and code injection. |
| [imping-ir](https://github.com/WoefulWolf/imping-ir) | The intermediate representation (IR) types and JSON Schema. |
| [imping-codegen](https://github.com/WoefulWolf/imping-codegen) | Rust bindings from IR, plus `imping-build` for build scripts and the `imping` CLI. |
| [imping-runtime](https://github.com/WoefulWolf/imping-runtime) | What generated bindings call into: module identity checks, globals and hooks. |
| [imping-ghidra](https://github.com/WoefulWolf/imping-ghidra) | A Ghidra script that exports a program as IR. |

Inside this checkout the components build against each other's local copies, through `.cargo/config.toml`.

[API docs](https://woefulwolf.github.io/imping/) · Early development, Windows x64 only for now.

If imping helped your project, a mention or link back is appreciated. I'd also love to see what you make with it: share it in [Show and tell](https://github.com/WoefulWolf/imping/discussions/categories/show-and-tell), and it might get featured here!

## License

Licensed under either of [Apache-2.0](LICENSE-APACHE) or [MIT](LICENSE-MIT), at your option.

AI assistance was used for parts of this project.
