# NixOS workstation drive configuration

{ config, pkgs, ... }:

{
  # Automounting additional drives
  # NOTE: comment these options if the drive configuration has changed to avoid errors.
  fileSystems = {
    "6TB-HDD" = {
      mountPoint = "/6TB-HDD";
      device = "/dev/disk/by-uuid/6ec96be9-3ca5-46cf-96f2-28aa84e3dacf";
      fsType = "ext4";
      label = "6TB-HDD";
    };

    "VM-SSD" = {
      mountPoint = "/VM-SSD";
      device = "/dev/disk/by-uuid/bac8097e-736c-48a4-9fbf-0ae206677c16";
      fsType = "ext4";
      label = "VM-SSD";
    };
  };
}
