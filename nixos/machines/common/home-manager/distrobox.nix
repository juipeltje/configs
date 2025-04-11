# NixOS Distrobox config

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "distrobox/distrobox.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/distrobox/distrobox.conf;
    };
  };
}
