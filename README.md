# Nix Flake Templates

## Usage

```sh
> mkdir my-project
> cd my-project
> nix flake init -t github:Plommonsorbet/nix-flake-templates#rust
> git init
> git add flake.nix
> nix build
```


## TODO Improvements

- Makefile with consistent build, run test, format, lint, generate docs, gen protobufs etc.
- .gitignore files for all templates


## TODO Additional templates

- terraform / terragrunt
- protobuf generation (maybe with buf?)
- document generation pdflatex, pandoc, cv etc?