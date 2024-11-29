# Nix Steam Deck config for applications outside of nixpkgs

{ config, pkgs, ... }:

{
  home.file = {
    "Appimages/DarkOrbit-Client.AppImage" = {
      enable = true;
      source = pkgs.fetchurl rec {                              
        pname = "Darkorbit-Client";
        version = "2.8.0";
        url = "https://github.com/kaiserdj/Darkorbit-client/releases/download/v${version}/${pname}-${version}.AppImage";
        hash = "sha256-PDRl0ezhY5btW/bvTT7SDvL5iAQsxu+Ls2AUsplyJOc=";
        executable = true;
      };
    };
  };

  xdg.desktopEntries = {
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
