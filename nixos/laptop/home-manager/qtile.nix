# NixOS laptop Qtile configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "qtile/config.py" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/qtile/config.py;
    };
  };
}
