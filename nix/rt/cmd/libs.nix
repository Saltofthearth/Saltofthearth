# RT / CMD - System Libraries
{ pkgs }:

{
  description = "@rt/@cmd/libs: Core low-level libraries and runtimes";
  packages = with pkgs; [
    glibc
    openssl
    zlib
    ncurses
  ];
}
