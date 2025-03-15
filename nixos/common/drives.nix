# NixOS drive configuration

{ config, pkgs, ... }:

{
  # Enable gvfs
  services.gvfs.package = pkgs.gvfs;
  services.gvfs.enable = true;

  # Enable fstrim
  services.fstrim.enable = true;
}
