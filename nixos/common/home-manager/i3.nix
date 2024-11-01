# NixOS i3 configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "i3/common.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/i3/common.conf;
    };

    "i3/rofi-powermenu.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/i3/rofi-powermenu.sh;
    };
  };
}
