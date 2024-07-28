# NixOS workstation package configuration

{ config, pkgs, ... }:

{

  # workstation-specific packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Python
    (python312.withPackages (subpkgs: with subpkgs; [ liquidctl docopt psutil ]))

    # Kanshi
    kanshi
  ];
}
