# Home Manager Yazi configuration

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "yazi/keymap.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/yazi/keymap.toml;
    };

    "yazi/yazi.toml" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/yazi/yazi.toml;
    };
  };
}
