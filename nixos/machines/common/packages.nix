# NixOS packages configuration

{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Allow unfree packages.
      nixpkgs.config.allowUnfree = true;
  
      # Font packages to install.
      fonts.packages = with pkgs; [ 
        nerd-fonts.mononoki
        nerd-fonts.ubuntu
      ];

      # Bash prompt.
      programs.bash.promptInit = ''
        PS1="\[\e[0;32m\] \u@\h  \W  \[\e[m\]"
      '';

      # Enable Git, Nano, Gnupg, Htop, appimage-run, and Evolution.
      programs = {
        git.enable = true;
        nano = {
          enable = true;
          syntaxHighlight = true;
        };
   
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
          pinentryPackage = pkgs.pinentry-curses;
        };

        htop = {
          enable = true;
          package = pkgs.htop;
        };

        appimage = {
          enable = true;
        };

        evolution = {
          enable = true;
        };
      };

      # Enable bluetooth support.
      hardware.bluetooth = {
        enable = true;
        package = pkgs.bluez;
      };

      # Enable Blueman.
      services.blueman.enable = true;

      # Improve Blueman applet systemd service so that it can be called by graphical-session.target.
      systemd.user.services.blueman-applet = {
        enable = true;
        description = "Bluetooth management applet"; 
        partOf = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          Restart = "on-failure";
        };
      };

      # Enable Soteria (polkit authentication agent).
      security.soteria.enable = true;

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        # Networking
        transmission_4-gtk

        # Terminal
        alacritty
        kitty

        # File managers/utilities
        yazi
        pcmanfm
        unzip
        unrar
        gnutar
        xz
        p7zip

        # Notifications
        libnotify

        # Office suite
        libreoffice

        # Multimedia
        alsa-utils
        pavucontrol
        mpv
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

        # Python
        #(python312.withPackages (subpkgs: with subpkgs; [ qtile qtile-extras ]))

        # Other
        lm_sensors
        (pass.withExtensions (subpkgs: with subpkgs; [ pass-otp ]))
        gparted
        curl
        wget
        autotiling
      ];
    }

    (lib.mkIf (config.networking.hostName == "NixOS-Rig") {
      # Enable OpenRGB and Yoda.
      services.hardware = {
        openrgb = {
          enable = true;
          motherboard = "amd";
        };

        yoda = {
          enable = true;
        };
      };
    })

    (lib.mkIf (config.networking.hostName == "NixOS-Lappie") {
      # Laptop-specific packages installed in system profile.
      environment.systemPackages = with pkgs; [
        # Control screen brightness.
        brightnessctl

        # Control volume with volume function keys.
        pulsemixer
      ];
    })
  ];
}


