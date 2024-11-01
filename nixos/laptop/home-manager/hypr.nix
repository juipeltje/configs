# NixOS laptop Hyprland configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/hypr/hyprland.conf;
    };

    "hypr/autostart.sh" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/hypr/autostart.sh;
    };
  };
}
