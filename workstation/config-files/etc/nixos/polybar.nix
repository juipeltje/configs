# NixOS workstation polybar config

{ config, pkgs, ... }:

{

  xdg.configFile = {
    "polybar/config.ini" = {
      enable = true;
      source = ./polybar/config.ini;
    };

    "polybar/launch.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        # Terminate already running bar instances
        killall -q polybar

        # Launch bars
        polybar bar1 &
        polybar bar2 &
      '';
    };
  };
}
