# NixOS workstation home-manager config

{ config, pkgs, ... }:

{
  # Packages to install in the user environment
  home-manager.users.joppe = { pkgs, ... }: {
    home.packages = [ ];
    imports = [
      ./alacritty.nix
      ./bash.nix
      ./dunst.nix
      ./git.nix
      ./hypr.nix
      ./i3.nix
      ./mako.nix
      ./mpv.nix
      ./polybar.nix
      ./qtile.nix
      ./rofi.nix
      ./swayfx.nix
      ./theming.nix
      ./virt-manager.nix
      ./waybar.nix
      ./wofi.nix
      ./xinitrc.nix
      ./yazi.nix
    ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}
