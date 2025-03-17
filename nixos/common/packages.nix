# NixOS packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;
  
  # Font packages to install.
  fonts.packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ "Mononoki" "Ubuntu" ]; })
  ];

  # Bash prompt.
  programs.bash.promptInit = ''
    PS1="\[\e[0;32m\] \u@\h  \W  \[\e[m\]"
  '';

  # Enable Git, Nano, Gnupg, Htop, Yazi, appimage-run, and Librewolf.
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

    yazi = {
      enable = true;
    };

    appimage = {
      enable = true;
    };

    firefox = {
      enable = true;
      package = pkgs.librewolf;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        Preferences = {
          "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
          "cookiebanners.service.mode" = 2; # Block cookie banners
          "privacy.donottrackheader.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.resistFingerprinting" = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.downloads" = false;
        };

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
        };
      };
    };
  };

  # Enable bluetooth support.
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
  };

  services.blueman.enable = true;

  # Enable polkit.
  security.polkit.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Networking
    qbittorrent

    # Terminal
    alacritty
    kitty

    # File managers/utilities
    pcmanfm
    unzip
    unrar
    gnutar
    xz
    p7zip

    # E-mail
    #thunderbird

    # Notifications
    libnotify

    # Office suite
    libreoffice

    # Multimedia
    pavucontrol
    mpv
    feh
    mpdris2
    rmpc
    freetube

    # Fetch tools
    fastfetch

    # Theming/Fonts
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    numix-solarized-gtk-theme
    catppuccin-gtk
    dracula-theme
    phinger-cursors
    mint-y-icons
    (nerdfonts.override { fonts = [ "Mononoki" "Ubuntu" ]; })

    # Benchmarking
    s-tui
    stress-ng

    # Python
    (python312.withPackages (subpkgs: with subpkgs; [ qtile qtile-extras ]))

    # Other
    lm_sensors
    (pass.withExtensions (subpkgs: with subpkgs; [ pass-otp ]))
    gparted
    curl
    wget
    lxde.lxsession
    vscodium-fhs
    autotiling
  ];
}


