# NixOS i3 configs

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "i3/config" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."i3/config".source = ./../../../../dotfiles/workstation/dotconfig/i3/config;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."i3/config".source = ./../../../../dotfiles/laptop/dotconfig/i3/config;
    })
  ];
}
