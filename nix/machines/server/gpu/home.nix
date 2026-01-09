# Home Manager workstation configuration

{ config, pkgs, ... }:

{
  home = {
    username = "gpu";
    homeDirectory = "/home/gpu";
  };

  programs.home-manager.enable = true;
  imports = [
    # Driver settings
    ./../../common/drivers.nix
    # Package settings
    ./packages.nix
    # Nix settings
    ./../../common/nix.nix
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
