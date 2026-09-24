# MD - Manuals & Documentation
{ pkgs }:

{
  description = "@md/manual: Research taxonomies, user guides, and system docs";
  packages = with pkgs; [
    man-pages          # System manual pages
    mdbook             # Markdown book builder for documentation
  ];
}
