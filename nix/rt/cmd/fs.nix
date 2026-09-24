# RT / CMD - Filesystem Tools
{ pkgs }:

{
  description = "@rt/@cmd/fs: Filesystem utilities and storage management";
  packages = with pkgs; [
    zfs                # OpenZFS storage & snapshot engine
    e2fsprogs          # ext4 tools
    btrfs-progs        # Btrfs tools
    dosfstools         # FAT/FAT32 tools
  ];
}
