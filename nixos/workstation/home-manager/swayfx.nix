# NixOS workstation SwayFX configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "sway/config" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/sway/config;
    };
  };
}
