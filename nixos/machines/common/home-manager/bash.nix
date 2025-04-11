# NixOS Bash configs

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../../common/home/.bashrc;
    };
  };
}
