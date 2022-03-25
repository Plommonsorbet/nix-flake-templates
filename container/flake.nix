{
  description = "A Docker Container Flake.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ];
        };

        echoip-image = pkgs.dockerTools.buildLayeredImage {
          name = "echoip";
          tag = "latest";
          contents = [ pkgs.echoip ];
          config.Cmd = [ "/bin/echoip" ];
        };

      in
      rec {
        packages = flake-utils.lib.flattenTree {
          echoip-image = echoip-image;
        };

        defaultPackage = packages.echoip-image;

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ docker-compose ];
        };
      }
    );
}
