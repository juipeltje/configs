# NixOS Alacritty configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "alacritty/alacritty.toml" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/alacritty/alacritty.toml";
    };

    "alacritty/catppuccin-mocha.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/catppuccin-mocha.toml;
    };

    "alacritty/gruvbox-dark.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/gruvbox-dark.toml;
    };

    "alacritty/nord.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/nord.toml;
    };

    "alacritty/solarized-dark.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/solarized-dark.toml;
    };

    "alacritty/tokyonight.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/alacritty/tokyonight.toml;
    };
  };
}
