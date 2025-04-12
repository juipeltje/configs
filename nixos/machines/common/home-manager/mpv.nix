# Home Manager mpv configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "mpv/input.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mpv/input.conf;
    };

    "mpv/mpv.conf" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/mpv/mpv.conf;
    };
  };
}
