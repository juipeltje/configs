# NixOS Kitty configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "kitty/kitty.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/kitty.conf;
    };

    "kitty/gruvbox-material-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/gruvbox-material-dark.conf;
    };

    "kitty/nordic.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/nordic.conf;
    };

    "kitty/tokyo-night.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/tokyo-night.conf;
    };
  };
}
