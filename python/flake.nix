{
  description = "A Poetry Python flake.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    poetry2nix.url = "github:nix-community/poetry2nix";
  };


  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ poetry2nix.overlay ];
        };

        pythonPkg = pkgs.python39;

        hello-world-env = pkgs.poetry2nix.mkPoetryEnv {
          python = pythonPkg;
          projectDir = ./.;
          editablePackageSources = {
            app = ./.;
          };
        };

        hello-world = pkgs.poetry2nix.mkPoetryApplication {
          python = pythonPkg;
          projectDir = ./.;
        };

      in
      rec {
        packages = flake-utils.lib.flattenTree {
          hello-world = hello-world;
        };

        defaultPackage = packages.hello-world;

        apps.hello-world = flake-utils.lib.mkApp {
          drv = packages.hello-world;
        };

        defaultApp = apps.hello-world;

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ hello-world-env poetry ];
        };
      }
    );
}
