# NixOS Mako configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "mako/gruvbox-material-dark-config" = {
      enable = true;
      source = ./../../../common/home/dotconfig/mako/gruvbox-material-dark-config;
    };

    "mako/nordic-config" = {
      enable = true;
      source = ./../../../common/home/dotconfig/mako/nordic-config;
    };

    "mako/tokyonight-config" = {
      enable = true;
      source = ./../../../common/home/dotconfig/mako/tokyonight-config;
    };
  };
}
