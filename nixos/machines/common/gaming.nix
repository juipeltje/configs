# NixOS gaming configuration

{ config, inputs, pkgs, ... }:

{
  # Enable Vulkan.
  hardware.graphics.enable32Bit = true;

  # Enable Steam, Gamemode, and corectrl overclocking.
  programs = {
    steam.enable = true;
    gamemode.enable = true;
    corectrl.enable = true;
    corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
  };

  # install other gaming related packages
  environment.systemPackages = with pkgs; [
    # Wine/gamelaunchers
    bottles
    heroic
    prismlauncher
    mcpelauncher-ui-qt
  
    # Emulators
    duckstation
    pcsx2
    rpcs3
    unstable.shadps4
    dolphin-emu
    flycast
    
    # Benchmarking
    mangohud
    unigine-heaven
    unigine-valley
    unigine-superposition

    # Chat
    webcord
  ];

  # Enable anime game launchers
  programs = {
    honkers-launcher = { 
      enable = false;
      package = inputs.aagl.packages.x86_64-linux.honkers-launcher;
    };

    anime-game-launcher = {
      enable = true;
      package = inputs.aagl.packages.x86_64-linux.anime-game-launcher;
    };

    wavey-launcher = {
      enable = false;
      package = inputs.aagl.packages.x86_64-linux.wavey-launcher;
    };

    sleepy-launcher = {
      enable = false;
      package = inputs.aagl.packages.x86_64-linux.sleepy-launcher;
    };
  };

  # Disable aagl mismatch nagging :)
  aagl.enableNixpkgsReleaseBranchCheck = false;

  # Enable qcma for Ps Vita.
  programs.qcma.enable = true;
}
