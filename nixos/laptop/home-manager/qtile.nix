# NixOS laptop Qtile configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "qtile/config.py" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/qtile/config.py;
    };

    "qtile/autostart.sh" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/qtile/autostart.sh;
    };

    "qtile/rofi-theme-switcher.sh" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/qtile/rofi-theme-switcher.sh;
    };
  };
}
