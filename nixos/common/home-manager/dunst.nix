# NixOS Dunst configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "dunst/dunstrc-gruvbox-material-dark" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-gruvbox-material-dark;
    };

    "dunst/dunstrc-nordic" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-nordic;
    };

    "dunst/dunstrc-tokyonight" = {
      enable = true;
      source = ./../../../common/home/dotconfig/dunst/dunstrc-tokyonight;
    };
  };
}
