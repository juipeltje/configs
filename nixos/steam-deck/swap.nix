# NixOS Steam Deck swap configuration

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
    resumeDevice = "/dev/disk/by-uuid/40c2b5bb-ef01-4266-b7f3-c54dfabd303e";
    kernelParams = [ "resume_offset=23844864" ];
  };
}
