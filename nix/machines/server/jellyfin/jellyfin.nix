# Home Manager packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Install Jellyfin packages in home environment.
  home.packages = with pkgs; [
    jellyfin
    jellyfin-ffmpeg
  ];
}
