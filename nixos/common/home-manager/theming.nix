# NixOS theme settings

{ config, pkgs, ... }:

{
  # Install GTK theme packages to switch between
  home.packages = with pkgs; [
    nordic
    gruvbox-gtk-theme
    tokyonight-gtk-theme
    numix-solarized-gtk-theme
    magnetic-catppuccin-gtk
    dracula-theme
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
    font.package = (pkgs.nerdfonts.override { fonts = [ "Mononoki" "Ubuntu" ]; });
    font.name = "Ubuntu Nerd Font Medium";
    font.size = 11;
    theme.package = pkgs.magnetic-catppuccin-gtk;
    theme.name = "Catppuccin-GTK-Dark";
    iconTheme.package = pkgs.mint-y-icons;
    iconTheme.name = "Mint-Y-Aqua";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.package = pkgs.libsForQt5.qtstyleplugins;
    style.name = "gtk2";
  };
}
