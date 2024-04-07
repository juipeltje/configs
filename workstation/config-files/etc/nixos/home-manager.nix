# NixOS workstation home-manager config

{ config, pkgs, ... }:

{
  # Packages to install in the user environment
  home-manager.users.joppe = { pkgs, ... }: {
    home.packages = [ ];
    imports = [
      ./git.nix
      ./theming.nix
      ./bash.nix
      ./alacritty.nix
      ./xinitrc.nix
      ./dunst.nix
      ./virt-manager.nix
    ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}
