# NixOS Distrobox config

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "distrobox/distrobox.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/distrobox/distrobox.conf;
    };
  };
}
