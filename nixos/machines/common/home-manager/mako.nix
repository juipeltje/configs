# NixOS Mako configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "mako/catppuccin-mocha-config" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/mako/catppuccin-mocha-config;
    };

    "mako/gruvbox-dark-config" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/mako/gruvbox-dark-config;
    };

    "mako/nord-config" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/mako/nord-config;
    };

    "mako/solarized-dark-config" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/mako/solarized-dark-config;
    };

    "mako/tokyonight-config" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/mako/tokyonight-config;
    };
  };
}
