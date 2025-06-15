# Home Manager Niri configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "niri/config.kdl" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."niri/config.kdl".source = ./../../../../dotfiles/workstation/dotconfig/niri/config.kdl;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."niri/config.kdl".source = ./../../../../dotfiles/laptop/dotconfig/niri/config.kdl;
    })
  ];
}
