# Home Manager Fastfetch configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "fastfetch/config.jsonc" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/fastfetch/config.jsonc;
    };
  };
}
