# NixOS Wayland configuration

{ config, pkgs, ... }:

{
  # Enable wayland compositors, Xwayland, and waybar.
  programs = {
    river.enable = true;
    river.extraPackages = [ ];
    hyprland.enable = true;
    sway.enable = true;
    sway.package = pkgs.swayfx;
    sway.extraPackages = [ ];
    xwayland.enable = true;
    waybar.enable = true;
    waybar.package = pkgs.waybar;
  };

  # Additional wayland-specific packages
  environment.systemPackages = with pkgs; [
    # Notifications
    mako

    # Run launcher
    tofi

    # Wallpaper tools
    swaybg
    hyprpaper
    mpvpaper 
  ];
}
