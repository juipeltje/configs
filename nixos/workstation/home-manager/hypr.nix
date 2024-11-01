# NixOS workstation Hyprland configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/hypr/hyprland.conf;
    };

    "hypr/autostart.sh" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/hypr/autostart.sh;
    };
  };
}
