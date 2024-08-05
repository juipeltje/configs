# NixOS container configuration

{ config, pkgs, ... }:

{

  # Enable Docker and rootless mode.
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  # Install Distrobox.
  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
        
