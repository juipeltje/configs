# NixOS Waybar configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/catppuccin-mocha.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/catppuccin-mocha.css;
    };

    "waybar/gruvbox-dark.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/gruvbox-dark.css;
    };

    "waybar/modules-hyprland" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/modules-hyprland;
    };

    "waybar/modules-niri" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/modules-niri;
    };

    "waybar/modules-river" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/modules-river;
    };

    "waybar/modules-sway" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/modules-sway;
    };

    "waybar/nord.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/nord.css;
    };

    "waybar/solarized-dark.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/solarized-dark.css;
    };

    "waybar/style.css" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/waybar/style.css";
    };

    "waybar/tokyonight.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/waybar/tokyonight.css;
    };
  };
}
