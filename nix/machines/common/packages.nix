# Home Manager packages configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Allow unfree packages.
      nixpkgs.config.allowUnfree = true;

      # list of packages to install in user environment.
      home.packages = with pkgs; [
        # Networking
        transmission_4-gtk

        # Bluetooth
        blueman

        # Mail
        evolution # gnome-keyring has to be installed on the host system!

        # Terminal
        alacritty
        kitty

        # File managers/utilities
        yazi
        unzip
        unrar
        p7zip
        xdg-utils

        # Office suite
        libreoffice

        # Notifications
        libnotify

        # Multimedia
        playerctl
        pavucontrol
        mpv
        kodi-wayland
        feh
        deadbeef-with-plugins
        cyanrip
        picard
        makemkv
        mkvtoolnix
        ffmpeg
        streamrip
        imagemagick
        corrupter

        # Fetch tools
        fastfetch

        # Benchmarking
        s-tui
        stress-ng

        # AI
        ollama-rocm

        # Text editors
        helix

        # LSP
        bash-language-server
        shfmt
        nil
        ruff

        # Other
        lm_sensors
        curl
      ];

      # configure deadbeef plugins
      nixpkgs.overlays = [
        (final: prev: {
          deadbeef-with-plugins = prev.deadbeef-with-plugins.override {
            plugins = with prev.deadbeefPlugins; [ mpris2 ];
          };
        })
      ];
    }

    (lib.mkIf (hostName == "Void-Rig") {
      # Workstation-specific packages.
      home.packages = with pkgs; [
        # Python packages
        (python313.withPackages (subpkgs: with subpkgs; [ 
          (callPackage ./../../derivations/yoda/derivation.nix { })
          qtile 
          qtile-extras
          dbus-fast
          pyxdg
          iwlib
        ]))
      ];
    })
    
    (lib.mkIf (hostName == "Void-Lappie") {
      # Laptop-specific packages.
      home.packages = with pkgs; [
        # Python packages
        (python313.withPackages (subpkgs: with subpkgs; [ 
          qtile 
          qtile-extras
          dbus-fast
          pyxdg
          iwlib
        ]))
        
        # Control screen brightness.
        brightnessctl

        # Control volume with volume function keys.
        pulsemixer
      ];
    })
  ];
}


