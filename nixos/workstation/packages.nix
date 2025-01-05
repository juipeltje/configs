# NixOS workstation package configuration

{ config, pkgs, ... }:

{
  # Select kernel version.
  boot = {
    kernelPackages = pkgs.linuxPackages_6_11;
  };

  # workstation-specific packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Kanshi
    kanshi
  ];
}
