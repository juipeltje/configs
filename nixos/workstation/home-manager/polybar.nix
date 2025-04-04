# NixOS workstation Polybar configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "polybar/config.ini" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/polybar/config.ini;
    };

    "polybar/launch.sh" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/polybar/launch.sh;
    };
  };
}
