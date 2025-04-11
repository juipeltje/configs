# NixOS user configuration

{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joppe = {
    isNormalUser = true;
    description = "joppe";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
