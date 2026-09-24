# MD - Logging & Telemetry
{ pkgs }:

{
  description = "@md/logs: Telemetry, audit trails, and system logging";
  packages = with pkgs; [
    sysstat            # System performance statistics (sar, iostat)
    htop               # System process monitoring
  ];
}
