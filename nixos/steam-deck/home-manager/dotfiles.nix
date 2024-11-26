# Nix Steam Deck dotfiles

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../steam-deck/home/.bashrc;
    };
  };
}
