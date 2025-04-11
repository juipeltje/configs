# NixOS Fuzzel configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "fuzzel/catppuccin-mocha.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/fuzzel/catppuccin-mocha.ini;
    };

    "fuzzel/gruvbox-dark.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/fuzzel/gruvbox-dark.ini;
    };

    "fuzzel/nord.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/fuzzel/nord.ini;
    };

    "fuzzel/solarized-dark.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/fuzzel/solarized-dark.ini;
    };

    "fuzzel/tokyonight.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/fuzzel/tokyonight.ini;
    };
  };
}
