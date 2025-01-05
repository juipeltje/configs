# Steam Deck packages config

{ config, inputs, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # NixGL settings (not available yet in 24.05)
  #nixGL = {
  #  packages = inputs.nixgl.packages;
  #  defaultWrapper = "mesa";
  #};

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
    mint-y-icons

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
    shadps4
    dolphin-emu
    steam-rom-manager
    
    # Benchmarking
    unigine-heaven
    unigine-valley
    unigine-superposition

    # Containerization
    distrobox

    # Anime game launchers
    inputs.aagl.packages.x86_64-linux.anime-game-launcher
    inputs.aagl.packages.x86_64-linux.honkers-launcher

    # NixGL
    inputs.nixgl.packages.x86_64-linux.nixGLIntel
    inputs.nixgl.packages.x86_64-linux.nixVulkanIntel
  ];
}


