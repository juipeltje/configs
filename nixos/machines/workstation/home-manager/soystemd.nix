# Home Manager workstation Systemd services configuration

{ config, pkgs, ... }:

{
  # Systemd service for OpenRGB.
  systemd.user.services = {
    openrgb = {
      Unit = {
        Description = "OpenRGB GUI minimized in tray";
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
