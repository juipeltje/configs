# NixOS Bash configs

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../../dotfiles/common/.bashrc;
    };
  };
}
