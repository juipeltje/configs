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
        networkmanagerapplet
        transmission_4-gtk

        # Mail
        evolution
        gnome-keyring

        # Terminal
        alacritty
        kitty

        # File managers/utilities
        yazi
        pcmanfm
        unzip
        unrar
        p7zip

        # Office suite
        libreoffice

        # Multimedia
        #alsa-utils
        pavucontrol
        mpv
        kodi-wayland
        feh
        audacious
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

        # Python
        #(python312.withPackages (subpkgs: with subpkgs; [ qtile qtile-extras ]))

        # Other
        lm_sensors
        (pass.withExtensions (subpkgs: with subpkgs; [ pass-otp ]))
        #gparted
        curl
        #wget
        autotiling
      ];
    }

    (lib.mkIf (hostName == "Void-Lappie") {
      # Laptop-specific packages installed in system profile.
      home.packages = with pkgs; [
        # Control screen brightness.
        brightnessctl

        # Control volume with volume function keys.
        pulsemixer
      ];
    })
  ];
}


