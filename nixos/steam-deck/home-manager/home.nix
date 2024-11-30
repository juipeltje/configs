# Nix Steam Deck home-manager config

{ config, pkgs, ... }:

{
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  programs.home-manager.enable = true;
  imports = [
      # Distrobox settings
      ./../../common/home-manager/distrobox.nix
      # Dotfiles
      ./dotfiles.nix
      # Git settings
      ./../../common/home-manager/git.nix
      # mpv settings
      ./../../common/home-manager/mpv.nix
      # Non-nix applications
      ./non-nix.nix
      # Non-steam game launch scripts
      ./non-steam.nix
      # Packages
      ./packages.nix
      # Theme settings
      ./../../common/home-manager/theming.nix
      # Yazi settings
      ./../../common/home-manager/yazi.nix
    ];

  # Enable flakes and additional cachix servers.
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      extra-substituters = [ "https://ezkea.cachix.org/" ];
      extra-trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
    };
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
