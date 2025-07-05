# Home Manager laptop configuration

{ config, pkgs, ... }:

{
  home = {
    username = "joppe";
    homeDirectory = "/home/joppe";
  };

  programs.home-manager.enable = true;
  imports = [
    # Driver settings
    ./../../common/drivers.nix
    # Librewolf settings
    ./../../common/librewolf.nix
    # Nix settings
    ./../../common/nix.nix
    # vscode settings
    ./../../common/vscode.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
