# NixOS Workstation Waybar configs

{ config, pkgs, ... }:

{

  # Hyprland waybar configs
  xdg.configFile = {
    "waybar/hyprland-config" = {
      enable = true;
      source = ./waybar/hyprland-config;
    };

    "waybar/hyprland-nordic-config" = {
      enable = true;
      source = ./waybar/hyprland-nordic-config;
    };

    # Hyprland waybar styles
    "waybar/hyprland-style-gruv.css" = {
      enable = true;
      source = ./waybar/hyprland-style-gruv.css;
    };

    "waybar/hyprland-style-nordic.css" = {
      enable = true;
      source = ./waybar/hyprland-style-nordic.css;
    };

    "waybar/hyprland-style.css" = {
      enable = true;
      source = ./waybar/hyprland-style.css;
    };

    # Sway waybar configs
    "waybar/sway-config" = {
      enable = true;
      source = ./waybar/sway-config;
    };

    "waybar/sway-nordic-config" = {
      enable = true;
      source = ./waybar/sway-nordic-config;
    };

    # Sway waybar styles
    "waybar/sway-style-gruvbox.css" = {
      enable = true;
      source = ./waybar/sway-style-gruvbox.css;
    };

    "waybar/sway-style-nordic.css" = {
      enable = true;
      source = ./waybar/sway-style-nordic.css;
    };

    "waybar/sway-style.css" = {
      enable = true;
      source = ./waybar/sway-style.css;
    };
  };
}
