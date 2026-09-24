# UX - Terminal User Interfaces
{ pkgs }:

{
  description = "@ux/tui: High-density terminal interfaces and tools";
  packages = with pkgs; [
    htop
    tmux
    fzf
  ];
}
