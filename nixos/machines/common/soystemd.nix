# NixOS Systemd configuration

{ config, pkgs, ... }:

{
  # Systemd sleep config
  systemd = { 
    sleep.extraConfig = ''
      HibernateDelaySec=1h
    '';
  };
}
