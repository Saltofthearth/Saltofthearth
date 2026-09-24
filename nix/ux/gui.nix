# UX - Graphical User Interfaces
{ pkgs }:

{
  description = "@ux/gui: Graphical interfaces and Wayland compositors";
  packages = with pkgs; [
    sway               # Lightweight Wayland compositor
    hyprland           # Dynamic tiling Wayland compositor
    wayland            # Core Wayland protocol
    foot               # Fast Wayland terminal emulator
    mako               # Wayland notification daemon
  ];
}
