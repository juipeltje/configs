# NixOS workstation Bash config

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../workstation/home/.bashrc;
    };
  };
}
