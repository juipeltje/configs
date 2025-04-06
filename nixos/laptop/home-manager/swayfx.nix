# NixOS laptop SwayFX configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "sway/config" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/sway/config;
    };
  };
}
