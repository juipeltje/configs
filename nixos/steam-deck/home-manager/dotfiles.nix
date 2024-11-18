# Nix Steam Deck dotfiles

{ config, pkgs, ... }:

{
  home.file = {
    ".bashrc" = {
      enable = true;
      source = ./../../../steam-deck/home/.bashrc;
    };
  };

  xdg.configFile = {
    "nix/nix.conf" = {
      enable = true;
      source = ./../../../steam-deck/home/dotconfig/nix/nix.conf;
    };
  };
}
