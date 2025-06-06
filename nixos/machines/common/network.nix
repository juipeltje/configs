# NixOS network configuration

{ config, pkgs, ... }:

{
  # Enable Networkmanager and firewall.
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  # Enable networkmanager applet.
  programs.nm-applet = {
    enable = true;
    indicator = false;
  };

  # Add restart on-failure to nm-applet systemd service ( applet sometimes fails to start on hyprland).
  systemd.user.services.nm-applet.serviceConfig.Restart = "on-failure";

  # Enable Mullvad vpn.
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  # Enable openssh
  services.openssh.enable = true;
}
