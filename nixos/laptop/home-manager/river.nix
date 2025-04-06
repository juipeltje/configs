# NixOS laptop River configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "river/init" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/river/init;
    };
  };
}
