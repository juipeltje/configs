# Home Manager packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Install Navidrome in home environment.
  home.packages = with pkgs; [
    navidrome
    # jellyfin
    # jellyfin-ffmpeg
  ];

  # Install Navidrome configuration to home folder.
  xdg.configFile."navidrome/navidrome.toml" = {
    enable = true;
    source = ./../../../../dotfiles/server/dotconfig/navidrome/navidrome.toml;
  };
}
