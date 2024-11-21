# Home-manager packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Enable Firefox, Yazi, mpv, Feh, Freetube, Fastfetch, and Mangohud.
  programs = {
    firefox.enable = true;
    yazi.enable = true;
    mpv.enable = true;
    feh.enable = true;
    freetube.enable = true;
    fastfetch.enable = true;
    mangohud.enable = true;
  };

  # List of packages to install in the user environment.
  home.packages = with pkgs; [
    # File managers/utilities
    strawberry

    # Theming/Fonts
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    phinger-cursors
    cinnamon.mint-y-icons

    # Wine/gamelaunchers
    bottles
    heroic
    prismlauncher

    # Game streaming
    chiaki4deck
  
    # Emulators
    duckstation
    pcsx2
    rpcs3
    unstable.shadps4
    dolphin-emu
    steam-rom-manager
    
    # Benchmarking
    unigine-heaven
    unigine-valley
    unigine-superposition

    # Containerization
    distrobox
  ];
}


