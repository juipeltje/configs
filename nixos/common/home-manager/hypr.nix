# NixOS Hyprland configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/common.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/common.conf;
    };

    "hypr/tofi-powermenu.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/tofi-powermenu.sh;
    };
  };
}
