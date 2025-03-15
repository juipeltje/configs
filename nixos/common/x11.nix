# NixOS X11 configuration

{ config, pkgs, ... }:

{
  # Enable the X11 windowing system, configure X11 keymap, X11 window managers, and Kodi.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    excludePackages = [ pkgs.xterm ];
    windowManager = {
      i3.enable = true;
      i3.extraPackages = [ ];
      #qtile.enable = true;
      #qtile.extraPackages = python3Packages: with python3Packages; [ qtile-extras ];
    };

    displayManager = {
      startx.enable = true;
    };

    desktopManager = {
      kodi.enable = true;
      kodi.package = pkgs.kodi;
    };
  };

  # Additional xorg-specific packages
  environment.systemPackages = with pkgs; [
    # Bar
    polybarFull

    # Notifications
    dunst

    # Run launcher
    rofi

    # Compositor
    unstable.picom

    # Other tools 
    xdotool
    xorg.xhost
  ];
}
