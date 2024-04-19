# NixOS mpv config

{ config, pkgs, ... }:

{

  programs.mpv = {
    enable = true;
    config = {
      loop-file = "inf";
    };

    bindings = {
      r = "cycle_values video-rotate 90 180 270 0";
    };
  };
}
