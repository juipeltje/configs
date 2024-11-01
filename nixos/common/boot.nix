# NixOS boot configuration

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  # Plymouth
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };

  # distro-grub-themes
  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };
}
