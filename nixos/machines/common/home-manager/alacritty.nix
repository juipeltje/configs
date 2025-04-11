# NixOS Alacritty configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "alacritty/catppuccin-mocha.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/catppuccin-mocha.toml;
    };

    "alacritty/gruvbox-dark.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/gruvbox-dark.toml;
    };

    "alacritty/nord.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/nord.toml;
    };

    "alacritty/solarized-dark.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/solarized-dark.toml;
    };

    "alacritty/tokyonight.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/tokyonight.toml;
    };
  };
}
