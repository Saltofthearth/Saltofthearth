# MD - Customization & Ricing
{ pkgs }:

{
  description = "@md/customization: Desktop customization, themes, dynamic color palette";
  packages = with pkgs; [
    pywal              # Dynamic color palette generator from wallpaper
  ];
}
