# Nix Steam Deck scripts for launching non-steam games/apps

{ config, pkgs, ... }:

{
  home.file = {
    "non-steam/firefox.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/firefox.sh;
    };

    "non-steam/freetube.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/freetube.sh;
    };

    "non-steam/prismlauncher.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/prismlauncher.sh;
    };
  };
}
