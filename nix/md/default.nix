# MD - Consolidated MD Layer
{ pkgs }:

let
  ai = import ./ai.nix { inherit pkgs; };
  server = import ./server.nix { inherit pkgs; };
  systemConfig = import ./system-config.nix { inherit pkgs; };
  manual = import ./manual.nix { inherit pkgs; };
  accessibility = import ./accessibility.nix { inherit pkgs; };
  powerManager = import ./power-manager.nix { inherit pkgs; };
  customization = import ./customization.nix { inherit pkgs; };
  memory = import ./memory.nix { inherit pkgs; };
  logs = import ./logs.nix { inherit pkgs; };
in
{
  description = "@md: System Domain & Specialized Modules";
  packages = ai.packages ++ server.packages ++ systemConfig.packages ++ manual.packages ++ accessibility.packages ++ powerManager.packages ++ customization.packages ++ memory.packages ++ logs.packages;
  submodules = {
    inherit ai server systemConfig manual accessibility powerManager customization memory logs;
  };
}
