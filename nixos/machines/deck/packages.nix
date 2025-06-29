# NixOS Steam Deck packages configuration

{ config, pkgs, ... }:

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
  #environment.systemPackages = with pkgs; [
  #];
}


