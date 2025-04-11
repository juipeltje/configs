# NixOS Waybar configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/catppuccin-mocha.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/catppuccin-mocha.css;
    };

    "waybar/gruvbox-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/gruvbox-dark.css;
    };

    "waybar/modules-hyprland" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-hyprland;
    };

    "waybar/modules-niri" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-niri;
    };

    "waybar/modules-river" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-river;
    };

    "waybar/modules-sway" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/modules-sway;
    };

    "waybar/nord.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/nord.css;
    };

    "waybar/solarized-dark.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/solarized-dark.css;
    };

    "waybar/tokyonight.css" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/waybar/tokyonight.css;
    };
  };
}
