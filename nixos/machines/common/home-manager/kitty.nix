# NixOS Kitty configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "kitty/catppuccin-mocha.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/kitty/catppuccin-mocha.conf;
    };

    "kitty/gruvbox-dark.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/kitty/gruvbox-dark.conf;
    };

    "kitty/nord.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/kitty/nord.conf;
    };

    "kitty/solarized-dark.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/kitty/solarized-dark.conf;
    };

    "kitty/tokyonight.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/kitty/tokyonight.conf;
    };
  };
}
