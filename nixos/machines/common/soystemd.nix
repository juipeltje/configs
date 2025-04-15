# NixOS Systemd configuration

{ config, pkgs, ... }:

{
  # Disable Dunst service ( was causing hanging issues with home manager).
  systemd = { 
    user.services = {
      dunst = {
        enable = false;
      };
    };

    # Systemd sleep config
    sleep.extraConfig = ''
      HibernateDelaySec=1h
    '';
  };
}
