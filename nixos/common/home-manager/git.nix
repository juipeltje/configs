# NixOS Git config

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "git/config" = {
      enable = true;
      source = ./../../../common/home/dotconfig/git/config;
    };
  };
}
