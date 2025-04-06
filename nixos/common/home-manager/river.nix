# NixOS River configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "river/colors-catppuccin-mocha.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-catppuccin-mocha.sh;
    };

    "river/colors-gruvbox-dark.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-gruvbox-dark.sh;
    };

    "river/colors-nord.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-nord.sh;
    };

    "river/colors-solarized-dark.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-solarized-dark.sh;
    };

    "river/colors-tokyonight.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-tokyonight.sh;
    };
  };
}
