# MD - Memory & Archiving
{ pkgs }:

{
  description = "@md/memory: Knowledge archiving, caching, storage tiering, wear-leveling";
  packages = with pkgs; [
    restic             # Secure backup & deduplication system
    ipfs               # InterPlanetary File System for decentralized storage
  ];
}
