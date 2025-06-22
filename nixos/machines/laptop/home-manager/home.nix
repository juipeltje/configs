# Home Manager laptop configuration

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
    # DWL settings
    ./../../common/home-manager/dwl.nix
    # Fastfetch settings
    ./../../common/home-manager/fastfetch.nix
    # Foot settings
    ./../../common/home-manager/foot.nix
    # Fuzzel settings
    ./../../common/home-manager/fuzzel.nix
    # Git settings
    ./../../common/home-manager/git.nix
    # gtklock settings
    ./../../common/home-manager/gtklock.nix
    # Hyprland settings
    ./../../common/home-manager/hypr.nix
    # i3 settings
    ./../../common/home-manager/i3.nix
    # Kanshi settings
    ./../../common/home-manager/kanshi.nix
    # Kitty settings
    ./../../common/home-manager/kitty.nix
    # Librewolf settings
    ./../../common/home-manager/librewolf.nix
    # Mako settings
    ./../../common/home-manager/mako.nix
    # maomao settings
    ./../../common/home-manager/maomao.nix
    # mpd settings
    #./../../common/home-manager/mpd.nix
    # mpv settings
    ./../../common/home-manager/mpv.nix
    # mwc settings
    ./../../common/home-manager/mwc.nix
    # Niri settings
    ./../../common/home-manager/niri.nix
    # Picom settings
    ./../../common/home-manager/picom.nix
    # Polybar settings
    ./../../common/home-manager/polybar.nix
    # Qtile settings
    ./../../common/home-manager/qtile.nix
    # River settings
    ./../../common/home-manager/river.nix
    # Rofi settings
    ./../../common/home-manager/rofi.nix
    # SwayFX settings
    ./../../common/home-manager/swayfx.nix
    # Swayidle settings
    ./../../common/home-manager/swayidle.nix
    # Symlink settings
    ./../../common/home-manager/symlinks.nix
    # Theme settings
    ./../../common/home-manager/theming.nix
    # Virt-manager settings
    ./../../common/home-manager/virt-manager.nix
    # vscode settings
    ./../../common/home-manager/vscode.nix
    # Waybar settings
    ./../../common/home-manager/waybar.nix
    # Wayland settings
    ./../../common/home-manager/wayland.nix
    # X11 settings
    ./../../common/home-manager/x11.nix
    # Yazi settings
    ./../../common/home-manager/yazi.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
