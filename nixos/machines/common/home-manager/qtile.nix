# Home Manager Qtile configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "qtile/colors.py" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/qtile/colors.py;
        };

        "qtile/common.py" = {
          enable = true;
          source = ./../../../../dotfiles/common/dotconfig/qtile/common.py;
        };

        "qtile/config.py" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."qtile/config.py".source = ./../../../../dotfiles/workstation/dotconfig/qtile/config.py;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."qtile/config.py".source = ./../../../../dotfiles/laptop/dotconfig/qtile/config.py;
    })
  ];
}
