# NixOS workstation Systemd services

{ config, pkgs, ... }:

{
  # create OpenRGB and ollama systemd service
  systemd.user.services = {
    openrgb = {
      Unit = {
        Description = "Start OpenRGB GUI minimized in tray";
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = { 
        ExecStart = "${pkgs.openrgb}/bin/openrgb --startminimized -p team-red.orp"; 
        Restart = "on-failure";
      };
    };
  };
}
