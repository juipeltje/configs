# NixOS Qtile configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "qtile/colors.py" = {
      enable = true;
      source = ./../../../common/home/dotconfig/qtile/colors.py;
    };
  };
}
