# NixOS mpv configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "mpv/input.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/mpv/input.conf;
    };

    "mpv/mpv.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/mpv/mpv.conf;
    };
  };
}
