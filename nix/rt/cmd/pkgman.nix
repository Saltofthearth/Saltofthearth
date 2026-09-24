# RT / CMD - Package Manager
{ pkgs }:

{
  description = "@rt/@cmd/pkgman: Package management and declarative tooling";
  packages = with pkgs; [
    nix                # Pure functional package manager
    nix-output-monitor # Visual Nix build output tracking
    nvd                # Nix package diff tool
  ];
}
