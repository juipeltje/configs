# NixOS autologin configuration

{ config, pkgs, ... }:

{
  # set the user that will be logged in automatically
  services.getty.autologinUser = "joppe";
}
