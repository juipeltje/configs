# Home Manager Foot configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "foot/catppuccin-mocha.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/foot/catppuccin-mocha.ini;
    };

    "foot/dracula.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/foot/dracula.ini;
    };

    "foot/foot.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/foot/foot.ini;
    };

    "foot/gruvbox-dark.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/foot/gruvbox-dark.ini;
    };

    "foot/nord.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/foot/nord.ini;
    };

    "foot/solarized-dark.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/foot/solarized-dark.ini;
    };

    "foot/tokyonight.ini" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/foot/tokyonight.ini;
    };
  };
}
