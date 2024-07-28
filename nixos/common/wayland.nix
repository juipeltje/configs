# NixOS Wayland configuration

{ config, pkgs, ... }:

{

  # Enable wayland compositors, Xwayland, and waybar.
  programs = {
    river.enable = true;
    river.extraPackages = [ ];
    hyprland.enable = true;
    sway.enable = false;
    sway.package = pkgs.swayfx;
    sway.extraPackages = [ ];
    xwayland.enable = true;
    waybar.enable = true;
    waybar.package = pkgs.waybar;
  };
}
