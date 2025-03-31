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
    # Workstation-specific Systemd settings
    ./soystemd.nix
    # Theme settings
    ./../../common/home-manager/theming.nix
    # Virt-manager settings
    ./virt-manager.nix
    # common Wayland settings
    ./../../common/home-manager/wayland.nix
    # common X11 settings
    ./../../common/home-manager/x11.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
