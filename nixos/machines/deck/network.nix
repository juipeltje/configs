# NixOS Steam Deck network configuration

{ config, pkgs, ... }:

{
  # Enable Mullvad vpn.
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  # Enable openssh
  services.openssh.enable = true;
}
