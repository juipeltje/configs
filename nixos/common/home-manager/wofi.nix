# NixOS Wofi configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "wofi/config" = {
      enable = true;
      source = ./../../../common/home/dotconfig/wofi/config;
    };

    "wofi/gruvbox-material-dark-style.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/wofi/gruvbox-material-dark-style.css;
    };

    "wofi/nordic-style.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/wofi/nordic-style.css;
    };

    "wofi/tokyonight-style.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/wofi/tokyonight-style.css;
    };
  };
}
