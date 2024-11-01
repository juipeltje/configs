# NixOS Alacritty configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "alacritty/alacritty.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/alacritty.toml;
    };

    "alacritty/gruvbox-material-dark.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/gruvbox-material-dark.toml;
    };

    "alacritty/nordic.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/nordic.toml;
    };

    "alacritty/tokyo-night.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/tokyo-night.toml;
    };
  };
}
