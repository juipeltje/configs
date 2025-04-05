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
    # Fuzzel settings
    ./../../common/home-manager/fuzzel.nix
    # Git settings
    ./../../common/home-manager/git.nix
    # gtklock settings
    ./../../common/home-manager/gtklock.nix
    # Hyprland common settings
    ./../../common/home-manager/hypr.nix
    # Hyprland workstation-specific settings
    ./hypr.nix
    # i3 common settings
    ./../../common/home-manager/i3.nix
    # i3 workstation-specific settings
    ./i3.nix
    # Kanshi settings
    ./kanshi.nix
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
    # Niri settings
    ./niri.nix
    # Picom settings
    ./../../common/home-manager/picom.nix
    # Polybar settings
    ./polybar.nix
    # Qtile common settings
    ./../../common/home-manager/qtile.nix
    # Qtile workstation-specific settings
    ./qtile.nix
    # River common settings
    ./../../common/home-manager/river.nix
    # River workstation-specific settings
    ./river.nix
    # Rofi settings
    ./../../common/home-manager/rofi.nix
    # SwayFX common settings
    ./../../common/home-manager/swayfx.nix
    # SwayFX workstation-specific settings
    ./swayfx.nix
    # Symlink common settings
    ./../../common/home-manager/symlinks.nix
    # Symlink workstation-specific settings
    ./symlinks.nix
    # Systemd workstation-specific settings
    ./soystemd.nix
    # Theme settings
    ./../../common/home-manager/theming.nix
    # Virt-manager settings
    ./virt-manager.nix
    # Waybar common settings
    ./../../common/home-manager/waybar.nix
    # Waybar workstation-specific settings
    ./waybar.nix
    # Wayland common settings
    ./../../common/home-manager/wayland.nix
    # X11 common settings
    ./../../common/home-manager/x11.nix
    # Yazi settings
    ./../../common/home-manager/yazi.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
