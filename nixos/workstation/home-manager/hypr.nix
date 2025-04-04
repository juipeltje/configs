# NixOS workstation Hyprland configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/hypr/hyprland.conf;
    };
  };
}
