# NixOS Yazi configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "yazi/keymap.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/yazi/keymap.toml;
    };

    "yazi/yazi.toml" = {
      enable = true;
      source = ./../../../common/home/dotconfig/yazi/yazi.toml;
    };
  };
}
