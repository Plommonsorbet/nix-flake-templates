{
  description = "Project templates";

  outputs = { self }: {

    templates = {

      simple = {
        path = ./simple;
        description = "A simple Flake Boilerplate";
      };

      go = {
        path = ./go;
        description = "A Go Project Flake";
      };

      python = {
        path = ./python;
        description = "A Python Poetry Project Flake";
      };

      rust = {
        path = ./rust;
        description = "A Rust Project Flake";
      };

      compatibility = {
        path = ./compatibility;
        description = "Nix Flake Compatibility Layer";
      };

      container = {
        path = ./container;
        description = "A Docker Container Flake";
      };

    };

    defaultTemplate = self.templates.simple;

  };
}
