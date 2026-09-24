# UX - Consolidated UX Layer
{ pkgs }:

let
  tui = import ./tui.nix { inherit pkgs; };
  gui = import ./gui.nix { inherit pkgs; };
  audio = import ./audio.nix { inherit pkgs; };
in
{
  description = "@ux: User Experience & HCI (TUI, GUI, Audio)";
  packages = tui.packages ++ gui.packages ++ audio.packages;
  submodules = {
    inherit tui gui audio;
  };
}
