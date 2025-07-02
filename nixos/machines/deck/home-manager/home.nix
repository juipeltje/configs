# Home Manager Steam Deck configuration

{ config, pkgs, ... }:

{
  home = {
    username = "deck";
    homeDirectory = "/home/deck";
  };

  programs.home-manager.enable = true;
  imports = [
    # Bash settings
    #./../../common/home-manager/bash.nix
    # Fastfetch settings
    #./../../common/home-manager/fastfetch.nix
    # Librewolf settings
    ./../../common/home-manager/librewolf.nix
    # Nix settings
    ./../../common/nix.nix
    # NixGL settings
    ./../../common/home-manager/nixgl.nix
    # vscode settings
    #./../../common/home-manager/vscode.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
