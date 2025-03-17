# NixOS Wayland configuration

{ config, pkgs, ... }:

{
  # Enable wayland compositors, Xwayland, and waybar.
  programs = {
    river = {
      enable = true;
      extraPackages = [ ];
    };

    sway = {
      enable = true;
      package = pkgs.swayfx;
      extraPackages = [ ];
    };

    waybar = {
      enable = true;
      package = pkgs.waybar;
    };

    hyprland.enable = true;
    niri.enable = false;
    xwayland.enable = true;
  };

  # Additional wayland-specific packages
  environment.systemPackages = with pkgs; [
    # Notifications
    mako

    # Run launcher
    tofi
    fuzzel

    # Wallpaper tools
    swaybg
    hyprpaper
    mpvpaper 

    # xwayland
    xwayland-satellite

    # screenlocker
    gtklock
  ];
}
