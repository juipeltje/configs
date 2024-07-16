# NixOS workstation network configuration

{ config, pkgs, ... }:

{

  # Enable networkmanager.
  networking = {
    networkmanager.enable = true;
  };

  # Enable Mullvad vpn.
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  # Enable openssh
  services.openssh.enable = true;

  # Firewall settings
  networking.firewall.enable = false;
}
