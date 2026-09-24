# RT / CMD - System Shells
{ pkgs }:

{
  description = "@rt/@cmd/shell: Interactive and scripting command shells";
  packages = with pkgs; [
    bashInteractive
    zsh
    nushell
  ];
}
