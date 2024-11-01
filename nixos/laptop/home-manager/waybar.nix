# NixOS laptop Waybar configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/river-config" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/river-config;
    };

    "waybar/river-style-gruvbox-material-dark.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/river-style-gruvbox-material-dark.css;
    };

    "waybar/river-style-nordic.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/river-style-nordic.css;
    };

    "waybar/river-style-tokyonight.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/river-style-tokyonight.css;
    };

    "waybar/hyprland-config" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/hyprland-config;
    };

    "waybar/hyprland-style-gruvbox-material-dark.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/hyprland-style-gruvbox-material-dark.css;
    };

    "waybar/hyprland-style-nordic.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/hyprland-style-nordic.css;
    };

    "waybar/hyprland-style-tokyonight.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/hyprland-style-tokyonight.css;
    };

    "waybar/sway-config" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/sway-config;
    };

    "waybar/sway-style-gruvbox-material-dark.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/sway-style-gruvbox-material-dark.css;
    };

    "waybar/sway-style-nordic.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/sway-style-nordic.css;
    };

    "waybar/sway-style-tokyonight.css" = {
      enable = true;
      source = ./../../../laptop/home/dotconfig/waybar/sway-style-tokyonight.css;
    };
  };
}
