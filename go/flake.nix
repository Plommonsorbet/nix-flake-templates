{
  description = "A Go Module Nix Flake.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    gomod2nix-src.url = "github:tweag/gomod2nix";
  };

  outputs = { self, nixpkgs, flake-utils, gomod2nix-src }:
    flake-utils.lib.eachDefaultSystem (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ gomod2nix-src.overlay ];
        };

        hello-world = pkgs.buildGoApplication {
          pname = "hello-world";
          version = "0.1";
          src = ./.;
          modules = ./gomod2nix.toml;
        };

      in
      rec {
        packages = flake-utils.lib.flattenTree { hello-world = hello-world; };

        defaultPackage = packages.hello-world;

        apps.hello-world =
          flake-utils.lib.mkApp { drv = packages.hello-world; };

        defaultApp = apps.hello-world;

        devShell =
          pkgs.mkShell { buildInputs = with pkgs; [ go_1_17 gomod2nix golangci-lint ]; };
      });
}
