# NixOS bootloader configuration

{ config, pkgs, ... }:

{

  # Bootloader.
  boot.loader = {
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "nodev";
    efi.canTouchEfiVariables = true;
  };
}
