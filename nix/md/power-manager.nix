# MD - Power Management
{ pkgs }:

{
  description = "@md/power-manager: Predictive power consumption, battery, display governor";
  packages = with pkgs; [
    powertop           # Power consumption diagnosis
    tlp                # Advanced power management
  ];
}
