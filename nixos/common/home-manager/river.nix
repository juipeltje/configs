# NixOS River configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "river/common.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/common.sh;
    };

    "river/colors-gruvbox-material-dark.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-gruvbox-material-dark.sh;
    };

    "river/colors-nordic.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-nordic.sh;
    };

    "river/colors-tokyonight.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/colors-tokyonight.sh;
    };

    "river/tofi-powermenu.sh" = {
      enable = true;
      source = ./../../../common/home/dotconfig/river/tofi-powermenu.sh;
    };
  };
}
