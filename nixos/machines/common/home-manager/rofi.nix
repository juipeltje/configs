# Home Manager Rofi configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "rofi/catppuccin-mocha.rasi" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rofi/catppuccin-mocha.rasi;
    };

    "rofi/config.rasi" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rofi/config.rasi;
    };

    "rofi/dracula.rasi" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rofi/dracula.rasi;
    };

    "rofi/gruvbox-dark.rasi" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rofi/gruvbox-dark.rasi;
    };

    "rofi/nord.rasi" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rofi/nord.rasi;
    };

    "rofi/solarized-dark.rasi" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rofi/solarized-dark.rasi;
    };

    "rofi/tokyonight.rasi" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rofi/tokyonight.rasi;
    };
  };
}
