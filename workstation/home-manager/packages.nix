# workstation packages config

{ config, lib, pkgs, nixgl, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # NixGL settings (not available yet in 24.05)
  nixGL = {
    packages = inputs.nixgl.packages;
    defaultWrapper = "mesa";
  };

  # Enable Librewolf, Freetube.
  programs = {
    librewolf = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.librewolf;
    };

    freetube = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.freetube;
    };
  };

  # List of packages to install in the user environment.
  home.packages = with pkgs; [
    # Theming/Fonts
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    phinger-cursors
    mint-y-icons

    # Wine/gamelaunchers
    bottles
    heroic

    # Emulators
    duckstation
    pcsx2
    rpcs3
    shadps4
    dolphin-emu
    
    # Benchmarking
    unigine-heaven
    unigine-valley
    unigine-superposition

    # Containerization
    distrobox
  ];
}


