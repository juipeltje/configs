# NixOS SwayFX configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "sway/colors-catppuccin-mocha.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-catppuccin-mocha.conf;
    };

    "sway/colors-gruvbox-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-gruvbox-dark.conf;
    };

    "sway/colors-nord.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-nord.conf;
    };

    "sway/colors-solarized-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-solarized-dark.conf;
    };

    "sway/colors-tokyonight.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-tokyonight.conf;
    };
  };
}
