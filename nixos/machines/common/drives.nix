# NixOS drive configuration

{ config, lib, pkgs, ... }:

{
  # Enable gvfs
  services.gvfs.package = pkgs.gvfs;
  services.gvfs.enable = true;

  # Enable fstrim
  services.fstrim.enable = true;

  # Automounting additional drives for workstation
  # NOTE: comment these options if the drive configuration has changed to avoid errors.
  fileSystems = lib.mkIf (config.networking.hostName == "NixOS-Rig") {
    "6TB-HDD" = {
      mountPoint = "/6TB-HDD";
      fsType = "ext4";
      label = "6TB-HDD";
    };
  };
}
