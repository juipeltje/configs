# NixOS Steam Deck config

{ config, pkgs, ... }:

{
  imports =
    [ 
      # Battery settings
      #./battery.nix
      # Boot settings
      ./../common/boot.nix
      # Container settings
      ./../common/containers.nix
      # Drive settings
      ./../common/drives.nix
      # Steam Deck-specific drive settings
      #./drives.nix
      # Environment variables
      ./../common/environment.nix
      # Gaming
      ./gaming.nix
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Hostname
      ./hostname.nix
      # Jovian settings
      ./jovian.nix
      # Locale settings
      ./../common/locale.nix
      # Network settings
      ./../common/network.nix
      # Packages
      ./packages.nix
      # Sound settings
      ./sound.nix
      # Swap settings
      #./swap.nix
      # Systemd service settings
      ./../common/soystemd.nix
      # User settings
      ./../common/users.nix
    ];

  # Enable flakes and additional cachix servers.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://ezkea.cachix.org/" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}