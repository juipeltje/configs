# NixOS autologin configuration

{ config, pkgs, ... }:

{
  # configure autologin.
  services.getty = {
    autologinUser = "joppe";
    autologinOnce = true;
  };
}
