# NixOS Dunst configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "dunst/dunstrc-catppuccin-mocha" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-catppuccin-mocha;
    };

    "dunst/dunstrc-gruvbox-dark" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-gruvbox-dark;
    };

    "dunst/dunstrc-nord" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-nord;
    };

    "dunst/dunstrc-solarized-dark" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-solarized-dark;
    };

    "dunst/dunstrc-tokyonight" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-tokyonight;
    };
  };
}
