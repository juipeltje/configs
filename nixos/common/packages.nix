# NixOS packages configuration

{ config, pkgs, ... }:

{

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Select kernel package version.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };
  
  # Font packages to install.
  fonts.packages = [ pkgs.nerdfonts ];

  # Bash prompt.
  programs.bash.promptInit = ''
    PS1="\[\e[0;31m\] \u  \W  \[\e[m\]"
  '';

  # Enable Nano, Gnupg, Git, Firefox, and Htop.
  programs = {
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

    git.enable = true;
    firefox.enable = true;
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
    networkmanagerapplet
    transmission-gtk

    # Terminal
    alacritty
    kitty

    # File managers/utilities
    pcmanfm
    yazi
    unzip
    gnutar
    xz
    p7zip

    # E-mail
    thunderbird

    # Notifications
    dunst
    mako
    libnotify

    # Run launchers
    rofi
    tofi
    wofi

    # Office suite
    libreoffice

    # Multimedia
    alsa-utils
    pavucontrol
    playerctl
    mpv
    feh
    deadbeef-with-plugins

    # Fetch tools
    fastfetch

    # Theming/Fonts
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    phinger-cursors
    cinnamon.mint-y-icons
    nerdfonts

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
    xdotool
    polybarFull
    swaybg
    hyprpaper
    mpvpaper
    appimage-run
    distrobox
    monero-gui
    vscodium-fhs
    autotiling
    psmisc
  ];
}


