{
  description = "A Go Module Template";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs = {
    fu.url = "github:numtide/flake-utils";
    gomod2nix.url = "github:nix-community/gomod2nix";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    fu,
    gomod2nix,
    flake-compat,
  }: (
    fu.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [gomod2nix.overlays.default];
      };

      goVersion = pkgs.go_1_19;

      app = pkgs.callPackage ./. {
        src = ./.;
        pwd = ./.;
        go = goVersion;
      };
    in {
      # Packages, can be built with `nix build .#` or `nix build .#hello-world`
      packages.hello-world = app;
      packages.default = app;

      # Runnables can be triggered with `nix run .#` or `nix run .#hello-world`
      apps = rec {
        default = hello-world;
        hello-world = {
          type = "app";
          program = "${app}/bin/hello-world";
        };
      };

      # Development shell triggered by `nix develop`
      devShells.default = pkgs.callPackage ./shell.nix {go = goVersion;};

      # Linter command triggered by: `nix flake check`
      checks.lint =
        pkgs.runCommand "go-lint" {
          nativeBuildInputs = with pkgs; [go golangci-lint];
        }
        ''
          cd ${./.}
          HOME=$TMPDIR golangci-lint run --config ${./.golangci.yml}
          # need to create out in order for this to be a valid derivation.
          touch $out
        '';

      # format all command triggerd by: `nix fmt`
      formatter = pkgs.writeShellApplication {
        name = "format-all";
        runtimeInputs = with pkgs; [goVersion alejandra gotools treefmt];
        text = ''
          treefmt
        '';
      };
    })
  );
}
