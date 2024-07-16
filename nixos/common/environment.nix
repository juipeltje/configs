# NixOS environment variables configuration

{ config, pkgs, ... }:

{

  # Environment variables.
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "gtk2";
  };
}
