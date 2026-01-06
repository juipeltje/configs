# Home Manager workstation configuration

{ config, pkgs, ... }:

{
  home = {
    username = "navidrome";
    homeDirectory = "/home/navidrome";
  };

  programs.home-manager.enable = true;
  imports = [
    # Navidrome settings
    ./navidrome.nix
    # Nix settings
    ./../../common/nix.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
