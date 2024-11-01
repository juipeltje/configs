# NixOS laptop home-manager config

{ config, pkgs, ... }:

{
  home.username = "joppe";
  home.homeDirectory = "/home/joppe";
  programs.home-manager.enable = true;
  imports = [
      # Alacritty settings
      ./../../common/home-manager/alacritty.nix
      # Bash settings
      ./bash.nix
      # Distrobox settings
      ./../../common/home-manager/distrobox.nix
      # Dunst settings
      ./../../common/home-manager/dunst.nix
      # Git settings
      ./../../common/home-manager/git.nix
      # Hyprland settings
      ./../../common/home-manager/hypr.nix
      # Laptop-specific Hyprland settings
      ./hypr.nix
      # i3 settings
      ./../../common/home-manager/i3.nix
      # Laptop-specific i3 settings
      ./i3.nix
      # Kitty settings
      ./../../common/home-manager/kitty.nix
      # Mako settings
      ./../../common/home-manager/mako.nix
      # mpv settings
      ./../../common/home-manager/mpv.nix
      # Bash_profile/xinitrc settings
      ./../../common/home-manager/other.nix
      # Picom settings
      ./../../common/home-manager/picom.nix
      # Polybar settings
      ./polybar.nix
      # Qtile settings
      ./../../common/home-manager/qtile.nix
      # Laptop-specific Qtile settings
      ./qtile.nix
      # River settings
      ./../../common/home-manager/river.nix
      # Laptop-specific River settings
      ./river.nix
      # Rofi settings
      ./../../common/home-manager/rofi.nix
      # SwayFX settings
      ./../../common/home-manager/swayfx.nix
      # Laptop-specific SwayFX settings
      ./swayfx.nix
      # Theme settings
      ./../../common/home-manager/theming.nix
      # Tofi settings
      ./../../common/home-manager/tofi.nix
      # Waybar settings
      ./waybar.nix
      # Wofi settings
      ./../../common/home-manager/wofi.nix
      # Yazi settings
      ./../../common/home-manager/yazi.nix
    ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
