# Home Manager mwc configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "mwc/mwc.conf" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."mwc/mwc.conf".source = ./../../../../dotfiles/workstation/dotconfig/mwc/mwc.conf;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."mwc/mwc.conf".source = ./../../../../dotfiles/laptop/dotconfig/mwc/mwc.conf;
    })
  ];
}
