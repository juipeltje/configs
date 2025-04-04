# NixOS workstation River configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "river/init" = {
      enable = true;
      source = ./../../../workstation/home/dotconfig/river/init;
    };
  };
}
