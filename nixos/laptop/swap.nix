# NixOS laptop swap configuration

{ config, pkgs, ... }:

{

  # swap file/hibernate to swap settings.
  # NOTE: when running a clean install, comment out "resumeDevice" and "kernelParams", 
  # then rebuild the system, find the offset of the swapfile by running:
  # "sudo filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//'"
  # in the terminal, and look up your root UUID in fstab, then enter the UUID at the end of
  # the "resumeDevice" line, uncomment it, and then enter the offset in "kernelParams" as
  # "resume_offset=$youroffsethere", uncomment it, and then rebuild the system again.
  swapDevices = [ { device = "/swapfile"; size = 24*1024; } ];

  boot = {
    resumeDevice = "/dev/disk/by-uuid/5bc94b90-7a94-427a-8ec0-e9a3cbe82917";
    kernelParams = [ "resume_offset=11720704" ];
  };
}
