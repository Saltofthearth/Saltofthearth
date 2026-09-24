# UX - Audio Interfaces
{ pkgs }:

{
  description = "@ux/audio: Audio processing, routing, and low-latency stack";
  packages = with pkgs; [
    pipewire           # Multimedia routing graph engine
    wireplumber        # PipeWire session manager
    pavucontrol        # PulseAudio / PipeWire volume control GUI
    alsa-utils         # ALSA sound utilities
  ];
}
