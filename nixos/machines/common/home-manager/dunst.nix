# Home Manager Dunst configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "dunst/dunstrc-catppuccin-mocha" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/dunst/dunstrc-catppuccin-mocha;
    };

    "dunst/dunstrc-dracula" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/dunst/dunstrc-dracula;
    };

    "dunst/dunstrc-gruvbox-dark" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/dunst/dunstrc-gruvbox-dark;
    };

    "dunst/dunstrc-nord" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/dunst/dunstrc-nord;
    };

    "dunst/dunstrc-solarized-dark" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/dunst/dunstrc-solarized-dark;
    };

    "dunst/dunstrc-tokyonight" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/dunst/dunstrc-tokyonight;
    };
  };
}
