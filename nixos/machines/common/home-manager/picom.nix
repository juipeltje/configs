# NixOS Picom configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "picom/picom.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/picom/picom.conf;
    };
  };
}
