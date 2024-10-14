# NixOS workstation package configuration

{ config, pkgs, ... }:

{
  
  # Select kernel version.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # workstation-specific packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Kanshi
    kanshi
  ];
}
