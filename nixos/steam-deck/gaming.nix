# NixOS Steam Deck gaming configuration

{ config, pkgs, inputs, ... }:

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
  environment.systemPackages = with pkgs.stable; [
    # Wine/gamelaunchers
    bottles
    heroic
    mangohud
    prismlauncher
  
    # Emulators
    duckstation
    pcsx2
    dolphin-emu
    
    # Benchmarking
    mangohud
    unigine-heaven
    unigine-valley
    unigine-superposition
  ];

  # install other gaming related packages from unstable
  environment.systemPackages = with pkgs.unstable; [
    # Emulators
    rpcs3
    shadps4
  ];

  # Enable anime game launchers
  programs = {
    honkers-launcher = { 
      enable = true;
      package = inputs.aagl.packages.x86_64-linux.honkers-launcher;
    };

    anime-game-launcher = {
      enable = true;
      package = inputs.aagl.packages.x86_64-linux.anime-game-launcher;
    };

    wavey-launcher = {
      enable = true;
      package = inputs.aagl.packages.x86_64-linux.wavey-launcher;
    };

    sleepy-launcher = {
      enable = true;
      package = inputs.aagl.packages.x86_64-linux.sleepy-launcher;
    };
  };

  # Disable aagl mismatch nagging :)
  aagl.enableNixpkgsReleaseBranchCheck = false;
}
