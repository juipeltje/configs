# NixOS Steam Deck gaming configuration

{ config, pkgs, inputs, ... }:

{
  # Enable Vulkan.
  hardware.graphics.enable32Bit = true;

  # Enable Steam, Gamemode, and corectrl overclocking.
  programs = {
    steam = { 
      enable = true;
      package = pkgs.steam.override {
        extraLibraries = [ pkgs.libGL ];
      };
    };

    gamemode.enable = true;
    corectrl.enable = true;
    corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
  };

  # install other gaming related packages
  environment.systemPackages = with pkgs; [
    # Wine/gamelaunchers
    stable.bottles
    stable.heroic
    stable.mangohud
    stable.prismlauncher
  
    # Emulators
    stable.duckstation
    stable.pcsx2
    rpcs3
    shadps4
    stable.dolphin-emu
    
    # Benchmarking
    stable.mangohud
    stable.unigine-heaven
    stable.unigine-valley
    stable.unigine-superposition
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

  programs.nix-ld = {
    enable = true;
    libraries = 
      pkgs.steam-run.args.multiPkgs
      pkgs;
  };
}
