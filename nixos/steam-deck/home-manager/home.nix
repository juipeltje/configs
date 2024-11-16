# NixOS workstation home-manager config

{ config, pkgs, ... }:

{
  home.username = "joppe";
  home.homeDirectory = "/home/joppe";
  programs.home-manager.enable = true;
  imports = [
      # Bash settings
      #./bash.nix
      # Distrobox settings
      ./../../common/home-manager/distrobox.nix
      # Git settings
      ./../../common/home-manager/git.nix
      # mpv settings
      ./../../common/home-manager/mpv.nix
      # Packages
      ./packages.nix
      # Theme settings
      ./../../common/home-manager/theming.nix
      # Yazi settings
      ./../../common/home-manager/yazi.nix
    ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
