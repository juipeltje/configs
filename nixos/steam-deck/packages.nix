# NixOS Steam Deck packages configuration

{ config, pkgs, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;
  
  # Font packages to install.
  fonts.packages = with pkgs.stable; [ 
    (nerdfonts.override { fonts = [ "Mononoki" "Ubuntu" ]; }) 
  ];

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
      pinentryPackage = pkgs.stable.pinentry-curses;
    };

    htop = {
      enable = true;
      package = pkgs.stable.htop;
    };

    git.enable = true;
    firefox.enable = true;
  };

  # Enable bluetooth support.
  hardware.bluetooth = {
    enable = true;
    package = pkgs.stable.bluez;
  };

  services.blueman.enable = true;

  # Enable polkit.
  security.polkit.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs.stable; [
    # Networking
    networkmanagerapplet
    #qbittorrent

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
    libnotify

    # Office suite
    libreoffice

    # Multimedia
    alsa-utils
    pavucontrol
    playerctl
    mpv
    feh
    strawberry
    freetube

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
    appimage-run
    monero-gui
    vscodium-fhs
    autotiling
  ];
}


