# NixOS laptop config

{ config, pkgs, ... }:

{
  imports =
    [ 
      # Battery settings
      ./battery.nix
      # Boot settings
      ./../common/boot.nix
      # Container settings
      ./../common/containers.nix
      # Drive settings
      ./../common/drives.nix
      # Environment variables
      ./../common/environment.nix
      # Gaming
      ./../common/gaming.nix
      # Greeter settings
      ./greeter.nix
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Hostname
      ./hostname.nix
      # Locale settings
      ./../common/locale.nix
      # Network settings
      ./../common/network.nix
      # Packages
      ./../common/packages.nix
      # Laptop-specific packages
      ./packages.nix
      # qcma custom module
      ./../common/modules/qcma.nix
      # Sound settings
      ./../common/sound.nix
      # Swap settings
      ./swap.nix
      # Systemd service settings
      ./../common/soystemd.nix
      # User settings
      ./../common/users.nix
      # Wayland settings
      ./../common/wayland.nix
      # X11 settings
      ./../common/x11.nix
      # Laptop-specific X11 settings
      ./x11.nix
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
