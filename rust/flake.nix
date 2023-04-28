{
  description = "A Rust Project flake with naersk and rust-overlay.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    naersk.url = "github:nix-community/naersk";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, naersk }:
    flake-utils.lib.eachDefaultSystem (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlay ];
        };

        rust_build = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
          extensions = [ "rust-src" "rls" "rust-analyzer" ];
          targets = [ "x86_64-unknown-linux-gnu" ];
        });

        naersk-lib = naersk.lib."${system}".override {
          rustc = rust_build;
          cargo = rust_build;
        };

        hello-world = naersk-lib.buildPackage {
          pname = "hello-world";
          root = ./.;
        };

      in
      rec {
        packages = flake-utils.lib.flattenTree {
          hello-world = hello-world;
        };

        defaultPackage = packages.hello-world;

        devShell =
          pkgs.mkShell {
            buildInputs = with pkgs; [
              rust_build
            ];
          };

      });
}
