# MD - System Configuration
{ pkgs }:

{
  description = "@md/system-config: Declarative state management and system profiles";
  packages = with pkgs; [
    home-manager       # Declarative user environment management
    git                # Version control for system configurations
  ];
}
