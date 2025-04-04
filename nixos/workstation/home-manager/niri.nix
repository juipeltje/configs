# NixOS workstation Niri configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "niri/config.kdl" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/workstation/home/dotconfig/niri/config.kdl";
    };
  };
}
