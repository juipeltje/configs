# NixOS boot configuration

{ config, pkgs, ... }:

{

  # Bootloader.
  boot.loader = {
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "nodev";
    efi.canTouchEfiVariables = true;
  };

  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };
}
