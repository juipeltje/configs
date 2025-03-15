# NixOS Rofi configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "rofi/config.rasi" = {
      enable = true;
      source = ./../../../common/home/dotconfig/rofi/config.rasi;
    };

    "rofi/gruvbox-material-dark.rasi" = {
      enable = true;
      source = ./../../../common/home/dotconfig/rofi/gruvbox-material-dark.rasi;
    };

    "rofi/nordic.rasi" = {
      enable = true;
      source = ./../../../common/home/dotconfig/rofi/nordic.rasi;
    };

    "rofi/tokyonight.rasi" = {
      enable = true;
      source = ./../../../common/home/dotconfig/rofi/tokyonight.rasi;
    };
  };
}
