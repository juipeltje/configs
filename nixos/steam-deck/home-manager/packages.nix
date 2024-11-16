# Home-manager packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Enable Yazi, mpv, Feh, Freetube, Fastfetch, and Mangohud.
  programs = {
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
  
    # Emulators
    duckstation
    pcsx2
    unstable.rpcs3
    unstable.shadps4
    dolphin-emu
    
    # Benchmarking
    unigine-heaven
    unigine-valley
    unigine-superposition
  ];
}


