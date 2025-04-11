# NixOS Polybar configs

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "polybar/config.ini" = {
          enable = true;
        };

        "polybar/launch.sh" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile = {
        "polybar/config.ini".source = ./../../../../workstation/home/dotconfig/polybar/config.ini;
        "polybar/launch.sh".source = ./../../../../workstation/home/dotconfig/polybar/launch.sh;
      };
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile = {
        "polybar/config.ini".source = ./../../../../laptop/home/dotconfig/polybar/config.ini;
        "polybar/launch.sh".source = ./../../../../laptop/home/dotconfig/polybar/launch.sh;
      };
    })
  ];
}
