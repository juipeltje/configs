# NixOS workstation River configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "river/init" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/river/init;
    };

    "river/autostart.sh" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/river/autostart.sh;
    };

    "river/tofi-theme-switcher.sh" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/river/tofi-theme-switcher.sh;
    };
  };
}
