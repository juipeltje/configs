# NixOS boot configuration

{ config, pkgs, ... }:

{
  # Bootloader + plymouth
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        timeoutStyle = "hidden";
        device = "nodev";
      };
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };

  # distro-grub-themes
  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };
}
