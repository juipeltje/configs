# Home Manager mpd configuration

{ config, pkgs, ... }:

{
  # Enable mpd and mpdris2
  services = {
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      network.startWhenNeeded = true;
      extraConfig = ''
        audio_output {
          type	"pipewire"
          name	"PipeWire Sound Server"
        }
      '';
    };

    mpdris2 = {
      enable = true;
      notifications = true;
    };
  };

  # Install mpd clients.
  home.packages = with pkgs; [
    unstable.rmpc
    plattenalbum
    ymuse
    ncmpcpp
  ];

  # rmpc configuration files.
  xdg.configFile = {
    "rmpc/config.ron" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rmpc/config.ron;
    };

    "rmpc/themes/default.ron" = {
      enable = true;
      source = ./../../../../dotfiles/common/dotconfig/rmpc/themes/default.ron;
    };
  };
}
