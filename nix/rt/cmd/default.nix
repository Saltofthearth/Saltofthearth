# RT / CMD - Consolidated
{ pkgs }:

let
  shell = import ./shell.nix { inherit pkgs; };
  libs = import ./libs.nix { inherit pkgs; };
  init = import ./init.nix { inherit pkgs; };
  fs = import ./fs.nix { inherit pkgs; };
  utils = import ./utils.nix { inherit pkgs; };
  pkgman = import ./pkgman.nix { inherit pkgs; };
in
{
  description = "@rt/@cmd: Core Userland Execution Environment";
  packages = shell.packages ++ libs.packages ++ init.packages ++ fs.packages ++ utils.packages ++ pkgman.packages;
  submodules = {
    inherit shell libs init fs utils pkgman;
  };
}
