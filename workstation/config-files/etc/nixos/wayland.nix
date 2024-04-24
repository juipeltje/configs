# NixOS workstation Wayland configuration

{ config, pkgs, ... }:

{

  # Enable wayland compositors, Xwayland, and waybar.
  programs = {
    hyprland.enable = true;
    sway.package = pkgs.swayfx;
    sway.enable = true;
    sway.extraPackages = [ ];
    xwayland.enable = true;
    waybar.enable = true;
    waybar.package = pkgs.waybar;
  };
}
