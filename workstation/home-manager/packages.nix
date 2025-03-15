# workstation packages config

{ config, lib, pkgs, inputs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # NixGL settings
  nixGL = {
    packages = inputs.nixgl.packages;
    defaultWrapper = "mesa";
  };

  # Enable Hyprland
  wayland.windowManager.hyprland = {
    enable = false;
    package = config.lib.nixGL.wrap pkgs.hyprland;
  };

  # Enable Librewolf, Freetube.
  programs = {
    librewolf = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.librewolf;
      settings = {
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.downloads" = false;
      };
        
      profiles = {
        default = {
          id = 0;
          isDefault = true;
          name = "default";
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin ];
          search = {
            default = "Brave";
            privateDefault = "Brave";
            force = true;
            engines = {
              "Brave" = {
                urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
                iconUpdateURL = "https://wiki.nixos.org/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@brave" ];
              };
            };
          };
        };
      };
    };

    freetube = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.freetube;
    };
  };

  # List of packages to install in the user environment.
  home.packages = with pkgs; [
    # Theming/Fonts
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    phinger-cursors
    mint-y-icons

    # Wine/gamelaunchers
    bottles
    (config.lib.nixGL.wrap pkgs.heroic)

    # Emulators
    duckstation
    pcsx2
    rpcs3
    shadps4
    dolphin-emu

    # Benchmarking
    unigine-heaven
    unigine-valley
    unigine-superposition

    # Containerization
    distrobox
  ];
}


