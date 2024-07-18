# NixOS Hyprland configs

{ config, pkgs, ... }:

{

  xdg.configFile = {
    "hypr/common.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/common.conf;
    };

    "hypr/wofi-powermenu.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/wofi-powermenu.sh;
    };
  };
}
