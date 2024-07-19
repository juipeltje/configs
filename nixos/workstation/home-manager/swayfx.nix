# NixOS workstation SwayFX configs

{ config, pkgs, ... }:

{

  xdg.configFile = {
    "sway/config" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/sway/config;
    };

    "sway/autostart.sh" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/sway/autostart.sh;
    };
  };
}
