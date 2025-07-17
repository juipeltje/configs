# Home Manager gaming configuration

{ config, inputs, pkgs, ... }:

{
  # install gaming related packages
  home.packages = with pkgs; [
    # Wine/gamelaunchers
    heroic-unwrapped # unwrapped version seems to be required in order for games to be able to launch on non-NixOS. might also be required for other packages?
    prismlauncher
    mcpelauncher-ui-qt
  
    # Emulators
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

    # qcma
    (libsForQt5.callPackage ./../../derivations/qcma/qcma.nix { })
  ];
}
