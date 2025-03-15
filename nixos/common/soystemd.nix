# NixOS Systemd services configuration

{ config, pkgs, ... }:

{
  systemd.user.services = {
    dunst = {
      enable = false;
    };
  };
}
