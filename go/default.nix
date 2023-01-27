{
  buildGoApplication,
  go,
  pwd,
  src,
}:
buildGoApplication {
  pname = "hello-world";
  version = "0.1";
  #pwd = ./.;
  #src = ./.;
  inherit src pwd go;
  modules = ./gomod2nix.toml;
}
