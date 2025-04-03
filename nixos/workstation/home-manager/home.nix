# NixOS workstation home-manager config

{ config, pkgs, ... }:

{
  home = {
    username = "joppe";
    homeDirectory = "/home/joppe";
  };

  programs.home-manager.enable = true;
  imports = [
    # Alacritty settings
    ./../../common/home-manager/alacritty.nix
    # Bash settings
    ./../../common/home-manager/bash.nix
    # Distrobox settings
    ./../../common/home-manager/distrobox.nix
    # Dunst settings
    ./../../common/home-manager/dunst.nix
    # Git settings
    ./../../common/home-manager/git.nix
    # Hyprland settings
    ./../../common/home-manager/hypr.nix
    # i3 settings
    ./../../common/home-manager/i3.nix
    # Kitty settings
    ./../../common/home-manager/kitty.nix
    # Librewolf settings
    ./../../common/home-manager/librewolf.nix
    # Mako settings
    ./../../common/home-manager/mako.nix
    # mpd settings
    ./../../common/home-manager/mpd.nix
    # mpv settings
    ./../../common/home-manager/mpv.nix
    # Picom settings
    ./../../common/home-manager/picom.nix
    # Qtile settings
    ./../../common/home-manager/qtile.nix
    # Rofi settings
    ./../../common/home-manager/rofi.nix
    # SwayFX settings
    ./../../common/home-manager/swayfx.nix
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
