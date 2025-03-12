# Nix workstation home-manager config

{ config, pkgs, ... }:

{
  home.username = "joppe";
  home.homeDirectory = "/home/joppe";
  programs.home-manager.enable = true;
  imports = [
      # Packages
      ./packages.nix
      # Theme settings
      ./../../common/home-manager/theming.nix
    ];

  # Enable flakes and additional cachix servers.
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
