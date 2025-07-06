# Home Manager gaming configuration

{ config, inputs, pkgs, ... }:

{
  # install gaming related packages
  home.packages = with pkgs; [
    # Wine/gamelaunchers
    steam
    bottles
    heroic
    prismlauncher
    mcpelauncher-ui-qt
  
    # Emulators
    duckstation
    pcsx2
    rpcs3
    shadps4
    dolphin-emu
    flycast
    
    # Benchmarking
    mangohud
    unigine-heaven
    unigine-valley
    unigine-superposition

    # Chat
    webcord

    # anime game launchers
    inputs.aagl.packages.x86_64-linux.honkers-launcher
    inputs.aagl.packages.x86_64-linux.anime-game-launcher
    inputs.aagl.packages.x86_64-linux.wavey-launcher
    inputs.aagl.packages.x86_64-linux.sleepy-launcher
  ];
}
