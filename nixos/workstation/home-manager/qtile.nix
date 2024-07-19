# NixOS workstation Qtile configs

{ config, pkgs, ... }:

{

  xdg.configFile = {
    "qtile/config.py" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/qtile/config.py;
    };

    "qtile/autostart.sh" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/qtile/autostart.sh;
    };
  };
}
