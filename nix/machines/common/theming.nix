# Home Manager theme configuration

{ config, pkgs, ... }:

{
  # Install gtk themes and font packages.
  home.packages = with pkgs; [
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    numix-solarized-gtk-theme
    magnetic-catppuccin-gtk
    dracula-theme
    nerd-fonts.ubuntu
    nerd-fonts.mononoki
  ];

  # Allow fontconfig to discover fonts installed through home.packages, and set default fonts.
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Ubuntu Nerd Font" ];
      sansSerif = [ "Ubuntu Nerd Font" ];
      monospace = [ "Mononoki Nerd Font" ];
    };
  };

  # Setting themes 
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    font.package = pkgs.nerd-fonts.ubuntu;
    font.name = "Ubuntu Nerd Font Medium";
    font.size = 11;
    theme.package = pkgs.gruvbox-gtk-theme;
    theme.name = "Gruvbox-Dark";
    iconTheme.package = pkgs.mint-y-icons;
    iconTheme.name = "Mint-Y-Aqua";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    #style.package = pkgs.libsForQt5.qtstyleplugins;
    style.name = "gtk2";
  };
}
