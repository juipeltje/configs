# NixOS laptop i3 configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "i3/config" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/i3/config;
    };

#    "i3/autostart.sh" = {
#      enable = true;
#      source = ./../../../laptop/home/dotconfig/i3/autostart.sh;
#    };
  };
}
