# Nix Steam Deck config for applications outside of nixpkgs

{ config, pkgs, ... }:

{
  home.file = {
    ".local/bin/anime-game-launcher" = {
      enable = true;
      source = pkgs.fetchurl rec {
        pname = "anime-game-launcher";
        version = "3.13.0";
        url = "https://github.com/an-anime-team/an-${pname}/releases/download/${version}/${pname}";
        hash = "";
        executable = true;
      };
    };

    "Appimages/DarkOrbit-Client.AppImage" = {
      enable = true;
      source = pkgs.fetchurl rec {                              
        pname = "Darkorbit-Client";
        version = "2.8.0";
        url = "https://github.com/kaiserdj/Darkorbit-client/releases/download/v${version}/${pname}-${version}.AppImage";
        hash = "";
        executable = true;
      };
    };
  };

  xdg.desktopEntries = {
    anime-game-launcher = {
      name = "An Anime Game Launcher";
      genericName = "An Anime Game Launcher";
      exec = "anime-game-launcher";
      categories = [ "Game" ];
      startupNotify = "true";
      type = "Application";
    };

    Darkorbit-Client = {
      name = "DarkOrbit";
      exec = "/home/deck/Appimages/DarkOrbit-Client.AppImage";
      categories = [ "Game" ];
      type = "Application";
    };

    Vita3K = {
      name = "Vita3K";
      exec = "/home/deck/Appimages/Vita3K.AppImage";
      categories = [ "Game" "Emulator" "X-None" ];
      type = "Application";
    };
  };
}
