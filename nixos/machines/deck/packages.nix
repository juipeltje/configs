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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [
  #];
}


