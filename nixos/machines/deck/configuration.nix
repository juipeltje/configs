# NixOS Steam Deck configuration

{ config, pkgs, ... }:

{
  imports = [ 
    # Battery settings
    #./battery.nix
    # Boot settings
    ./boot.nix
    # Container settings
    #./containers.nix
    # Gaming
    ./gaming.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Jovian settings
    ./jovian.nix
    # Locale settings
    ./locale.nix
    # Network settings
    ./network.nix
    # Packages
    ./packages.nix
    # Sound settings
    ./sound.nix
    # Swap settings
    #./swap.nix
    # User settings
    ./users.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
