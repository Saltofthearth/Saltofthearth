# RT / CMD - Init & Process Supervision
{ pkgs }:

{
  description = "@rt/@cmd/init: Init systems and service supervision";
  packages = with pkgs; [
    s6                 # Skarnet s6 supervision suite
    s6-rc              # s6 service manager
    execline           # Non-shell scripting language for s6
  ];
}
