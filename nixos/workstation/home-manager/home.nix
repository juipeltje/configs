# NixOS workstation home-manager config

{ config, pkgs, ... }:

{

  home.username = "joppe";
  home.homeDirectory = "/home/joppe";
  programs.home-manager.enable = true;
  imports = [
      # Alacritty settings
      ./../../common/home/alacritty.nix
      # Bash settings
      ./bash.nix
      # Dunst settings
      ./../../common/home/dunst.nix
      # Git settings
      ./../../common/home/git.nix
      # Hyprland settings
      ./../../common/home/hypr.nix
      # Workstation-specific Hyprland settings
      ./hypr.nix
      # i3 settings
      ./../../common/home/i3.nix
      # Workstation-specific i3 settings
      ./i3.nix
      # Mako settings
      ./../../common/home/mako.nix
      # mpv settings
      ./../../common/home/mpv.nix
      # Polybar settings
      ./polybar.nix
      # Qtile settings
      ./qtile.nix
      # Rofi settings
      ./../../common/home/rofi.nix
      # SwayFX settings
      ./../../common/home/swayfx.nix
      # Workstation-specific SwayFX settings
      ./swayfx.nix
      # Theme settings
      ./../../common/home/theming.nix
      # Virt-manager settings
      ./virt-manager.nix
      # Waybar settings
      ./waybar.nix
      # Wofi settings
      ./../../common/home/wofi.nix
      # Xinitrc settings
      ./../../common/home/xinitrc.nix
      # Yazi settings
      ./../../common/home/yazi.nix
    ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
