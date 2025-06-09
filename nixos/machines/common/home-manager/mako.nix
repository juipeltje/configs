# Home Manager Mako configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "mako/catppuccin-mocha-config" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mako/catppuccin-mocha-config;
    };

    "mako/dracula-config" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mako/dracula-config;
    };

    "mako/gruvbox-dark-config" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mako/gruvbox-dark-config;
    };

    "mako/nord-config" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mako/nord-config;
    };

    "mako/solarized-dark-config" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mako/solarized-dark-config;
    };

    "mako/tokyonight-config" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mako/tokyonight-config;
    };
  };
}
