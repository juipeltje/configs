# Home Manager Swayidle configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      xdg.configFile = {
        "swayidle/config" = {
          enable = true;
        };
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      xdg.configFile."swayidle/config".text = ''
        before-sleep '${pkgs.gtklock}/bin/gtklock -d --follow-focus'
        after-resume '${pkgs.openrgb}/bin/openrgb -p purple.orp'
      '';
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      xdg.configFile."swayidle/config".text = ''
        before-sleep '${pkgs.gtklock}/bin/gtklock -d --follow-focus'
      '';
    })
  ];
}
