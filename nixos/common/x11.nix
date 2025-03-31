# NixOS X11 configuration

{ config, pkgs, ... }:

{
  # Enable the X11 windowing system, configure X11 keymap, X11 window managers, Kodi, and Picom.
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      excludePackages = [ pkgs.xterm ];
      windowManager = {
        i3.enable = true;
        i3.extraPackages = [ ];
        qtile.enable = true;
        qtile.extraPackages = python3Packages: with python3Packages; [ qtile-extras ];
      };

      displayManager = {
        startx.enable = true;
      };

      desktopManager = {
        kodi.enable = true;
        kodi.package = pkgs.kodi;
      };
    };
  };

  # Additional xorg-specific packages
  environment.systemPackages = with pkgs; [
    # Bar
    polybarFull

    # Compositor
    picom

    # Notifications
    dunst

    # Run launcher
    rofi

    # Other tools 
    xdotool
    xorg.xhost
  ];

  # Systemd service for Picom, and setting up Systemd target for Qtile.
  systemd.user = {
    services = {
      picom = {
        enable = true;
        unitConfig = {
          Description = "Picom composite manager";
          PartOf = [ "qtile-session.target" ];
        };

        serviceConfig = {
          ExecStart = "${pkgs.picom}/bin/picom";
          Restart = "on-failure";
        };

        wantedBy = [ "qtile-session.target" ];
      };

      xset = {
        enable = true;
        unitConfig = {
          Description = "Run xset command on login";
          Type = "oneshot";
          PartOf = [ "qtile-session.target" ];
        };

        serviceConfig = {
          ExecStart = "${pkgs.xorg.xset}/bin/xset s off -dpms";
          Restart = "on-failure";
        };

        wantedBy = [ "qtile-session.target" ];
      };
    };

    targets = {
      qtile-session = {
        description = "Qtile session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };
    };
  };
}
