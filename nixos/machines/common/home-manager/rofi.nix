# NixOS Rofi configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "rofi/catppuccin-mocha.rasi" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/rofi/catppuccin-mocha.rasi;
    };

    "rofi/gruvbox-dark.rasi" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/rofi/gruvbox-dark.rasi;
    };

    "rofi/nord.rasi" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/rofi/nord.rasi;
    };

    "rofi/solarized-dark.rasi" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/rofi/solarized-dark.rasi;
    };

    "rofi/tokyonight.rasi" = {
      enable = true;
      source = ./../../../../common/home/dotconfig/rofi/tokyonight.rasi;
    };
  };
}
