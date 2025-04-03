# NixOS i3 configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "i3/common.conf" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/common/home/dotconfig/i3/common.conf";
    };
  };
}
