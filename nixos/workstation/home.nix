# NixOS workstation home-manager config

{ config, pkgs, ... }:

{

  home.username = "joppe";
  home.homeDirectory = "/home/joppe";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
