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
      ./i3.nix
      ./swayfx.nix
      ./hypr.nix
      ./xinitrc.nix
      ./dunst.nix
      ./virt-manager.nix
      ./wofi.nix
      ./yazi.nix
    ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}
