# NixOS Kanshi config

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "kanshi/config" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."kanshi/config".source = ./../../../../workstation/home/dotconfig/kanshi/config;
    })
  ];
}
