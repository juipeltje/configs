# NixOS workstation Kanshi config

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "kanshi/config" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/kanshi/config;
    };
  };
}
