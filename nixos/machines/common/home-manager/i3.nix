# Home Manager i3 configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "i3/common.conf" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/i3/common.conf;
        };
        
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
