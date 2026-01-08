# Home Manager workstation configuration

{ config, pkgs, ... }:

{
  home = {
    username = "jellyfin";
    homeDirectory = "/home/jellyfin";
  };

  programs.home-manager.enable = true;
  imports = [
    # Driver settings
    ./../../common/drivers.nix
    # Jellyfin settings
    ./jellyfin.nix
    # Nix settings
    ./../../common/nix.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
