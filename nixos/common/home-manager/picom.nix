# NixOS Picom configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "picom/picom.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/picom/picom.conf;
    };
  };
}
