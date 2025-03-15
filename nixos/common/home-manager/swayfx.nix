# NixOS SwayFX configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "sway/common.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/common.conf;
    };

    "sway/colors-gruvbox-material-dark.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-gruvbox-material-dark.conf;
    };

    "sway/colors-nordic.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-nordic.conf;
    };

    "sway/colors-tokyonight.conf" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/colors-tokyonight.conf;
    };

    "sway/tofi-powermenu.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/sway/tofi-powermenu.sh;
    };
  };
}
