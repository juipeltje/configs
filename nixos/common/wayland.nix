# NixOS Wayland configuration

{ config, lib, pkgs, ... }:

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
    niri.enable = true;
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

  # set up pam to make sure gtklock actually works.
  security.pam.services.gtklock = { };

  # xdg-desktop-portal settings
  xdg.portal.wlr.enable = lib.mkForce false;
}
