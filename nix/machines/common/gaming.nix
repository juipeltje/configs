# Home Manager gaming configuration

{ config, hostName, inputs, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # install gaming related packages
      home.packages = with pkgs; [
        # Gamelaunchers
        heroic-unwrapped # unwrapped version seems to be required in order for games to be able to launch on non-NixOS. might also be required for other packages?
        prismlauncher
        # mcpelauncher-ui-qt
  
        # Emulators
        pcsx2
        rpcs3
        shadps4
        dolphin-emu
        flycast
    
        # Benchmarking
        mangohud

        # Chat
        webcord

        # anime game launchers
        #inputs.aagl.packages.x86_64-linux.honkers-launcher
        #inputs.aagl.packages.x86_64-linux.anime-game-launcher
        #inputs.aagl.packages.x86_64-linux.wavey-launcher
        #inputs.aagl.packages.x86_64-linux.sleepy-launcher
      ];
    }

    (lib.mkIf (hostName == "Void-Rig") {
      home.packages = with pkgs; [
        # Benchmarking
        unigine-heaven
        unigine-valley
        unigine-superposition
      ];
    })

    (lib.mkIf (hostName == "Void-Rig" || hostName == "Void-Lappie") {
      home.packages = with pkgs; [
        # qcma
        (libsForQt5.callPackage ./../../derivations/qcma/qcma.nix { })
      ];
    })

    (lib.mkIf (hostName == "Void-Lappie" || hostName == "Deckie") {
      home.packages = with pkgs; [
        chiaki-ng
      ];
    })
  ];
}
