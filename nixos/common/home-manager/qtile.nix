# NixOS Qtile configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "qtile/common.py" = {
      enable = true;
      source = ./../../../common/home/dotconfig/qtile/common.py;
    };

    "qtile/colors.py" = {
      enable = true;
      source = ./../../../common/home/dotconfig/qtile/colors.py;
    };

    "qtile/rofi-powermenu.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/qtile/rofi-powermenu.sh;
    };
  };
}
