# NixOS laptop Bash config

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../laptop/home/.bashrc;
    };
  };
}
