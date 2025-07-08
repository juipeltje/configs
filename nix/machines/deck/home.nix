# Home Manager Steam Deck configuration

{ config, pkgs, ... }:

{
  home = {
    username = "deck";
    homeDirectory = "/home/deck";
  };

  programs.home-manager.enable = true;
  imports = [
    # Driver settings
    ./../common/drivers.nix
    # Gaming settings
    ./../common/gaming.nix
    # Librewolf settings
    ./../common/librewolf.nix
    # Nix settings
    ./../common/nix.nix
    # Packages settings
    ./../common/packages.nix
    # Theme settings
    ./../common/theming.nix
    # vscode settings
    ./../common/vscode.nix
    # Wayland settings
    ./../common/wayland.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
