# MD - Server & Mesh Networking
{ pkgs }:

{
  description = "@md/server: Sovereign hosting, mesh networks, and encrypted comms";
  packages = with pkgs; [
    wireguard-tools    # Encrypted VPN mesh network
    matrix-synapse     # Decentralized communication server
  ];
}
