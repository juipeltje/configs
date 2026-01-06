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

        # Text editors
        helix

        # Notifications
        libnotify

        # Fetch tools
        fastfetch

        # Benchmarking
        s-tui
        stress-ng

        # Containers
        # podman
        # podman-compose
        # podman-tui

        # Other
        lm_sensors
        curl
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

        # LSP
        bash-language-server
        shfmt
        nixd
        ruff
        clang-tools

        # Multimedia
        playerctl
        pavucontrol
        mpv
        feh
        cyanrip
        picard
        makemkv
        mkvtoolnix
        streamrip
        deno
        imagemagick
        corrupter
        ffmpeg
        feishin

        # AI
        ollama-rocm

        # other
        via
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
        # navidrome
        # jellyfin
        # jellyfin-ffmpeg
      ];
    })
  ];
}
