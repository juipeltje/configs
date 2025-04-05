# NixOS Workstation Waybar configs

{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/configs/workstation/home/dotconfig/waybar/config";
    };
  };
}
