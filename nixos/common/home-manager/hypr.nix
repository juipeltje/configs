# NixOS Hyprland configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/colors-catppuccin-mocha.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/colors-catppuccin-mocha.conf;
    };

    "hypr/colors-gruvbox-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/colors-gruvbox-dark.conf;
    };

    "hypr/colors-nord.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/colors-nord.conf;
    };

    "hypr/colors-solarized-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/colors-solarized-dark.conf;
    };

    "hypr/colors-tokyonight.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/hypr/colors-tokyonight.conf;
    };

    "hypr/common.conf" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/hypr/common.conf";
    };
  };
}
