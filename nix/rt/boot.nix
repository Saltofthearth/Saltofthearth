# RT - Boot, Kernel, Firmware, Drivers & Hardware Substrate
{ pkgs }:

{
  description = "@rt: Firmware, Drivers, Microcode, BIOS/UEFI, Initramfs, Bootloader, Kernel";

  # Declarative package sets for @rt boot components
  packages = with pkgs; [
    limine             # Limine Bootloader
    booster            # Fast Initramfs generator
    glibc              # Fundamental system C library
    kmod               # Kernel module management
    pciutils           # Hardware inspection (lspci)
    usbutils           # USB hardware inspection (lsusb)
  ];

  # Bootloader and Low-level specifications metadata
  metadata = {
    bootloader = "limine";
    initramfsGenerator = "booster";
    kernelTarget = "linux-zen / custom-sovereign-kernel";
    supportedArchitectures = [ "x86_64" "riscv64" ];
  };
}
