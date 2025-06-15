# Home Manager Alacritty configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "alacritty/alacritty.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/alacritty.toml;
    };
    
    "alacritty/catppuccin-mocha.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/catppuccin-mocha.toml;
    };

    "alacritty/dracula.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/alacritty/dracula.toml;
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
