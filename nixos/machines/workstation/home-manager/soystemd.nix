# Home Manager workstation Systemd services configuration

{ config, pkgs, ... }:

{
  # Systemd service for OpenRGB.
  systemd.user.services = {
    openrgb-profile = {
      Unit = {
        Description = "OpenRGB color profile";
        PartOf = [ "default.target" ];
      };

      Install = { WantedBy = [ "default.target" ]; };
      Service = { 
        Type = "oneshot";
        ExecStart = "${pkgs.openrgb}/bin/openrgb -p purple.orp";
        Restart = "on-failure";
      };
    };
  };
}
