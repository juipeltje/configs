# NixOS laptop Polybar configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "polybar/config.ini" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/polybar/config.ini;
    };

    "polybar/launch.sh" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/polybar/launch.sh;
    };
  };
}
