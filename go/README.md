# Hello World Template App

## Gomod2nix

**After changing your `go.mod` directly or through commands like `go mod tidy`, you'll need to re-generate the `gomod2nix.toml` file again, `Enter the Development Shell Environment` as described below and then run:**
```sh
gomod2nix generate
```

## Enter the Development Environment

```sh
nix develop
```
NOTE: while inside this devshell you can use all the go tooling directly, but they can also be triggered through nix commands as documented below.

## Lint

**Run nix & go(`golangci-lint`) lint**
```sh
nix flake check
```

## Formatting

**Format All (go, nix, w.e.):**
```
nix fmt
```
NOTE: this just runs the derivation specifed at `flake.outputs.formatter`, which in this case is `treefmt`. It's configured to run nix & gofmt & goimports, but more can be added.

## Building

**Build Default Package**
```
nix build .#
```

**Build `hello-world` Package**
```
nix build .#hello-world
```


## Running 

**Running Default Package**
```
nix run .#
```

**Running `hello-world` Package**
```
nix run .#hello-world
```

## Updating flake inputs

```sh
nix flake update
```


