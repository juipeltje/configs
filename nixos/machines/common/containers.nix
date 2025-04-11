# NixOS container configuration

{ config, pkgs, ... }:

{
  # Enable Podman.
  virtualisation.podman.enable = true;

  # Install Distrobox.
  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
        
