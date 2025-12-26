# Home Manager packages configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Allow unfree packages.
      nixpkgs.config.allowUnfree = true;

      # list of packages to install in user environment.
      home.packages = with pkgs; [
        # Terminal
        alacritty
        kitty

        # File managers/utilities
        yazi
        unzip
        unrar
        p7zip
        xdg-utils

        # Notifications
        libnotify

        # Multimedia
        playerctl
        pavucontrol
        mpv
        feh
        cyanrip
        picard
        makemkv
        mkvtoolnix
        ffmpeg
        streamrip
        deno
        imagemagick
        corrupter

        # Fetch tools
        fastfetch

        # Benchmarking
        s-tui
        stress-ng

        # AI
        ollama-rocm

        # Other
        lm_sensors
        curl
        via
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

    (lib.mkIf (hostName == "Void-Rig" || hostName == "Void-Lappie") {
      # Workstation- and laptop-specific packages.
      home.packages = with pkgs; [
        # Networking
        transmission_4-gtk

        # Bluetooth
        blueman

        # Mail
        thunderbird

        # Office suite
        libreoffice

        # Text editors
        helix

        # LSP
        bash-language-server
        shfmt
        nixd
        ruff
        clang-tools

        # Multimedia
        feishin

        # other
        unstable.displaycal
        gtypist
        klavaro
        kdePackages.ktouch
      ];
    })

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

    (lib.mkIf (hostName == "Void-Server") {
      # Server-specific packages.
      home.packages = with pkgs; [
        navidrome
      ];
    })
  ];
}
