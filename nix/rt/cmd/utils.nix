# RT / CMD - Utilities
{ pkgs }:

{
  description = "@rt/@cmd/utils: Core system utilities";
  packages = with pkgs; [
    toybox             # Lightweight embedded system utilities
    coreutils          # Standard GNU core utilities
    util-linux         # Essential Linux system utilities
    findutils          # Searching tools
  ];
}
