# Home Manager Steam Deck configuration

{ config, pkgs, ... }:

{
  home = {
    username = "joppe";
    homeDirectory = "/home/joppe";
  };

  programs.home-manager.enable = true;
  imports = [
    # Bash settings
    ./../../common/home-manager/bash.nix
    # Distrobox settings
    #./../../common/home-manager/distrobox.nix
    # Fastfetch settings
    #./../../common/home-manager/fastfetch.nix
    # Librewolf settings
    ./../../common/home-manager/librewolf.nix
    # vscode settings
    #./../../common/home-manager/vscode.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
