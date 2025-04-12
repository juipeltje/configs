# Home Manager Bash configuration

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../../dotfiles/common/.bashrc;
    };
  };
}
