# NixOS Qtile configs

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "qtile/colors.py" = {
          enable = true;
          source = ./../../../common/home/dotconfig/qtile/colors.py;
        };

        "qtile/config.py" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."qtile/config.py".source = ./../../../workstation/home/dotconfig/qtile/config.py;
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."qtile/config.py".source = ./../../../laptop/home/dotconfig/qtile/config.py;
    })
  ];
}
