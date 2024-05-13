# NixOS workstation Qtile configs

{ config, pkgs, ... }:

{

  xdg.configFile = {
    "qtile/config.py" = {
      enable = true;
      source = ./qtile/config.py;
    };

    "qtile/autostart.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash

        sleep 1
        xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0 &
        ~/.fehbg &
        #picom &
        dunst &
        playerctld daemon &
        lxsession &
        liquidctl initialize all &
        sleep 2
        liquidctl --match kraken set pump speed 100 &
        ~/repos/configs/Scripts/yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
        xset s off -dpms &
        nm-applet &
        openrgb &
      '';
    };
  };
}
