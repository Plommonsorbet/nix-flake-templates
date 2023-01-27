{
  mkShell,
  gomod2nix,
  golangci-lint,
  gotools,
  go,
  treefmt,
  alejandra,
}:
mkShell {
  packages = [
    gomod2nix
    golangci-lint
    gotools
    go
    treefmt
    alejandra
  ];
}
