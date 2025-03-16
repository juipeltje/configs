# NixOS laptop home-manager config

{ config, pkgs, ... }:

{
  home.username = "joppe";
  home.homeDirectory = "/home/joppe";
  programs.home-manager.enable = true;
  imports = [
      # Theme settings
      ./../../common/home-manager/theming.nix
    ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
