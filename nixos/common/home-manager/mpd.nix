# NixOS mpd settings

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
        	type            "pipewire"
        	name            "PipeWire Sound Server"
        }
      '';
    };

    mpdris2 = {
      enable = true;
      notifications = true;
    };
  };
}
