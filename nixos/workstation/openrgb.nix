# NixOS workstation OpenRGB configuration

{ config, pkgs, ... }:

{

  # Enable OpenRGB.
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # Enable i2c support.
  hardware.i2c.enable = true;

  # Add users to i2c group.
  users.users.joppe.extraGroups = [ "i2c" ];
}
