# NixOS Qtile configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "qtile/colors.py" = {
      enable = true;
      source = ./../../../common/home/dotconfig/qtile/colors.py;
    };

    "qtile/common.py" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/qtile/common.py";
    };
  };
}
