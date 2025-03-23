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

  # Enable Git, Nano, Gnupg, Htop, and appimage-run.
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
    yazi
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
    rmpc
    freetube

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
    vscodium-fhs
    autotiling
    polkit_gnome
  ];
}


