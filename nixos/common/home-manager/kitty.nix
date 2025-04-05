# NixOS Kitty configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "kitty/catppuccin-mocha.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/catppuccin-mocha.conf;
    };

    "kitty/gruvbox-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/gruvbox-dark.conf;
    };

    "kitty/kitty.conf" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/kitty/kitty.conf";
    };

    "kitty/nord.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/nord.conf;
    };

    "kitty/solarized-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/solarized-dark.conf;
    };

    "kitty/tokyonight.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/kitty/tokyonight.conf;
    };
  };
}
