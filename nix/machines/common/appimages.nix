# Home Manager appimages configuration

{ config, pkgs, ... }:

{
  home.file = {
    "Appimages/Vita3K.AppImage" = {
      enable = true;
      source = pkgs.fetchurl rec {                              
        pname = "Vita3K";
        version = "3807";
        url = "https://github.com/${pname}/${pname}-builds/releases/download/${version}/${pname}-x86_64.AppImage";
        hash = "sha256-N9S8qEsFgzayyWwqgE1EwSNBMajSJldlqyLwEK/GKJM=";
        executable = true;
      };
    };

    "Appimages/DuckStation.AppImage" = {
      enable = true;
      source = pkgs.fetchurl rec {                              
        pname = "DuckStation";
        version = "0.1-9226";
        url = "https://github.com/stenzek/duckstation/releases/download/v${version}/${pname}-x64.AppImage";
        hash = "sha256-1hJx8e6Qp5U6zxg8lco9LpzT/AblO92kHIK3SgJGeu8=";
        executable = true;
      };
    };
  };

  xdg.desktopEntries = {
    Vita3K = {
      name = "Vita3K";
      exec = "${config.home.homeDirectory}/Appimages/Vita3K.AppImage";
      categories = [ "Game" "Emulator" "X-None" ];
      type = "Application";
    };

    DuckStation = {
      name = "DuckStation";
      exec = "${config.home.homeDirectory}/Appimages/DuckStation.AppImage";
      categories = [ "Game" "Emulator" "X-None" ];
      type = "Application";
    };
  };
}
