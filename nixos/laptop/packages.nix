# NixOS laptop package configuration

{ config, pkgs, ... }:

{

  # Laptop-specific packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Control screen brightness.
    brightnessctl

    # Control volume with volume function keys.
    pulsemixer
  ];
}
