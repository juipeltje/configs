# NixOS gtklock configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "gtklock/catppuccin-mocha.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/catppuccin-mocha.css;
    };

    "gtklock/gruvbox-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/gruvbox-dark.css;
    };

    "gtklock/nord.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/nord.css;
    };

    "gtklock/solarized-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/solarized-dark.css;
    };

    "gtklock/tokyonight.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/gtklock/tokyonight.css;
    };
  };
}
