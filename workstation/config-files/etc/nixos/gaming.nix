# NixOS workstation gaming configuration

{ config, pkgs, ... }:

{

  # Enable Vulkan.
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

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
    mangohud
    prismlauncher
  
    # Emulators
    duckstation
    pcsx2
    rpcs3
    dolphin-emu
    
    # Benchmarking
    mangohud
    unigine-heaven
    unigine-valley
    unigine-superposition
  ];
}
