# Home Manager theme configuration

{ config, pkgs, ... }:

{
  # Install gtk themes and additional font packages.
  home.packages = with pkgs; [
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    numix-solarized-gtk-theme
    magnetic-catppuccin-gtk
    dracula-theme
    nerd-fonts.mononoki
  ];

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
