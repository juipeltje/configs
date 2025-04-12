# Home Manager Polybar configuration

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
        "polybar/config.ini".source = ./../../../../dotfiles/workstation/dotconfig/polybar/config.ini;
        "polybar/launch.sh".source = ./../../../../dotfiles/workstation/dotconfig/polybar/launch.sh;
      };
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile = {
        "polybar/config.ini".source = ./../../../../dotfiles/laptop/dotconfig/polybar/config.ini;
        "polybar/launch.sh".source = ./../../../../dotfiles/laptop/dotconfig/polybar/launch.sh;
      };
    })
  ];
}
