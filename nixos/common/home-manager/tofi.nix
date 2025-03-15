# NixOS Tofi configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "tofi/config" = {
      enable = true;
      source = ./../../../common/home/dotconfig/tofi/config;
    };

    "tofi/gruvbox-material-dark-colors" = {
      enable = true;
      source = ./../../../common/home/dotconfig/tofi/gruvbox-material-dark-colors;
    };

    "tofi/nordic-colors" = {
      enable = true;
      source = ./../../../common/home/dotconfig/tofi/nordic-colors;
    };

    "tofi/tokyonight-colors" = {
      enable = true;
      source = ./../../../common/home/dotconfig/tofi/tokyonight-colors;
    };
  };
}
