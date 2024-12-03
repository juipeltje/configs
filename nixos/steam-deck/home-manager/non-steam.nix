# Nix Steam Deck scripts for launching non-steam games/apps

{ config, pkgs, ... }:

{
  home.file = {
    "non-steam/agl.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/agl.sh;
    };

    "non-steam/bf2.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/bf2.sh;
    };

    "non-steam/chiaki.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/chiaki.sh;
    };

    "non-steam/cloudpunk.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/cloudpunk.sh;
    };

    "non-steam/firefox.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/firefox.sh;
    };

    "non-steam/freetube.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/freetube.sh;
    };

    "non-steam/jfo.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/jfo.sh;
    };

    "non-steam/prismlauncher.sh" = {
      enable = true;
      source = ./../../../steam-deck/home/non-steam/prismlauncher.sh;
    };
  };
}
