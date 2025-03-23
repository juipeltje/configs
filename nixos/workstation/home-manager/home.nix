# NixOS workstation home-manager config

{ config, pkgs, ... }:

{
  home = {
    username = "joppe";
    homeDirectory = "/home/joppe";
  };

  programs.home-manager.enable = true;
  imports = [
    # Git settings
    ./../../common/home-manager/git.nix
    # Librewolf settings
    ./../../common/home-manager/librewolf.nix
    # Sound settings
    ./../../common/home-manager/sound.nix
    # Theme settings
    ./../../common/home-manager/theming.nix
    # Virt-manager settings
    ./virt-manager.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
