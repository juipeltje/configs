# NixOS Steam Deck network configuration

{ config, pkgs, ... }:

{
  # Enable Networkmanager and firewall.
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  # Enable Mullvad vpn.
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  # Enable openssh
  services.openssh.enable = true;
}
