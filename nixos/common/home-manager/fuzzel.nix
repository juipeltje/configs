# NixOS Fuzzel configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "fuzzel/catppuccin-mocha.ini" = {
      enable = true;
      source = ./../../../common/home/dotconfig/fuzzel/catppuccin-mocha.ini;
    };

    "fuzzel/fuzzel.ini" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/fuzzel/fuzzel.ini";
    };

    "fuzzel/gruvbox-dark.ini" = {
      enable = true;
      source = ./../../../common/home/dotconfig/fuzzel/gruvbox-dark.ini;
    };

    "fuzzel/nord.ini" = {
      enable = true;
      source = ./../../../common/home/dotconfig/fuzzel/nord.ini;
    };

    "fuzzel/solarized-dark.ini" = {
      enable = true;
      source = ./../../../common/home/dotconfig/fuzzel/solarized-dark.ini;
    };

    "fuzzel/tokyonight.ini" = {
      enable = true;
      source = ./../../../common/home/dotconfig/fuzzel/tokyonight.ini;
    };
  };
}
