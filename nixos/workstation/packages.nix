# NixOS workstation package configuration

{ config, pkgs, ... }:

{
  
  # Select kernel version.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # workstation-specific packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Python
    (python312.withPackages (subpkgs: with subpkgs; [ liquidctl docopt psutil ]))

    # Kanshi
    kanshi
  ];
}
