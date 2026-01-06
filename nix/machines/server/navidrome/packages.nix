# Home Manager packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # list of packages to install in user environment.
  home.packages = with pkgs; [
    navidrome
    # jellyfin
    # jellyfin-ffmpeg
  ];
}
