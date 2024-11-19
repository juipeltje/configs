# Home-manager packages configuration

{ config, lib, pkgs, nixgl, ... }:

{
  # NixGL settings
  #nixGL.packages = nixgl.packages;
  #nixGL.defaultWrapper = "mesa";

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
    (config.lib.nixGL.wrap chiaki4deck)
  
    # Emulators
    duckstation
    pcsx2
    (config.lib.nixGL.wrap unstable.rpcs3)
    (config.lib.nixGL.wrap unstable.shadps4)
    #libcanberra
    #libcanberra-gtk3
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


