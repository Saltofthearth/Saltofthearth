# RT - Consolidated Runtime Layer
{ pkgs }:

let
  boot = import ./boot.nix { inherit pkgs; };
  cmd = import ./cmd/default.nix { inherit pkgs; };
in
{
  description = "@rt: Runtime / Base System Foundation";
  packages = boot.packages ++ cmd.packages;
  submodules = {
    inherit boot cmd;
  };
}
