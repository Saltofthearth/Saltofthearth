# MD - Accessibility & Input
{ pkgs }:

{
  description = "@md/accessibility: Assistive mechanisms, chorded input, speech-to-intent";
  packages = with pkgs; [
    evtest             # Input event driver inspector
    xdotool            # Synthetic input simulation
  ];
}
