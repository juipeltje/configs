# NixOS gtklock configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "gtklock/catppuccin-mocha.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/gtklock/catppuccin-mocha.css;
    };

    "gtklock/gruvbox-dark.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/gtklock/gruvbox-dark.css;
    };

    "gtklock/nord.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/gtklock/nord.css;
    };

    "gtklock/solarized-dark.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/gtklock/solarized-dark.css;
    };

    "gtklock/style.css" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/gtklock/style.css";
    };

    "gtklock/tokyonight.css" = {
      enable = true;
      source = ./../../../common/home/dotconfig/gtklock/tokyonight.css;
    };
  };
}
