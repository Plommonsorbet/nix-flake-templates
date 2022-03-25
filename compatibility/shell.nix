(import (
  builtins.fetchGit {
   	url = "https://github.com/edolstra/flake-compat.git";
	rev = "b7547d3eed6f32d06102ead8991ec52ab0a4f1a7";
	}
) {
  src =  ./.;
}).shellNix
