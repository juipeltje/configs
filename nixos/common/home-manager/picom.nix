# NixOS Picom configs

{ config, pkgs, ... }:

{

  xdg.configFiles = {
    "picom/picom.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/picom/picom.conf;
    };
  };
}
