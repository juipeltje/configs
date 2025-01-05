# NixOS theme settings

{ config, pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    font.package = pkgs.nerdfonts;
    font.name = "Ubuntu Nerd Font Medium";
    font.size = 11;
    theme.package = pkgs.tokyonight-gtk-theme;
    theme.name = "Tokyonight-Dark";
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
