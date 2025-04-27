# NixOS X11 configuration

{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Enable the X11 windowing system, configure X11 keymap, X11 window managers, Kodi, and Picom.
      services = {
        xserver = {
          enable = true;
          xkb.layout = "us";
          xkb.variant = "";
          excludePackages = [ pkgs.xterm ];
          videoDrivers = [ "amdgpu" ];
          windowManager = {
            i3.enable = true;
            i3.extraPackages = [ ];
            qtile.enable = true;
            qtile.extraPackages = python3Packages: with python3Packages; [ qtile-extras pyxdg dbus-fast ];
          };

          displayManager = {
            startx.enable = true;
          };

          desktopManager = {
            kodi.enable = true;
            kodi.package = pkgs.kodi;
          };
        };

        # Configure laptop touchpad.
        libinput.touchpad.additionalOptions = lib.mkIf (config.networking.hostName == "NixOS-Lappie") ''
          Option "Tapping" "on"
        ''; 
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

      # Systemd services for Picom, xrandr, xset, disabling Dunst service (was causing hanging issues with home manager), 
      # and setting up Systemd target for Qtile.
      systemd.user = {
        services = {
          picom = {
            enable = true;
            description = "Picom composite manager";
            partOf = [ "qtile-session.target" "i3-session.target" ];
            wantedBy = [ "qtile-session.target" "i3-session.target" ];
            serviceConfig = {
              ExecStart = "${pkgs.picom}/bin/picom";
              Restart = "on-failure";
            };
          };

          xrandr = {
            enable = true;
            description = "xrandr display configuration";
            partOf = [ "qtile-session.target" "i3-session.target" ];
            requiredBy = [ "feh.service" ];
            before = [ "feh.service" ];
            wantedBy = [ "qtile-session.target" "i3-session.target" ];
            serviceConfig = {
              Type = "oneshot";
              Restart = "on-failure";
            };
          }; 

          xset = {
            enable = true;
            description = "xset user preference utility for X";
            partOf = [ "qtile-session.target" "i3-session.target" ];
            wantedBy = [ "qtile-session.target" "i3-session.target" ];
            serviceConfig = {
              Type = "oneshot";
              ExecStart = "${pkgs.xorg.xset}/bin/xset s off -dpms";
              Restart = "on-failure";
            };
          };

          dunst.enable = false;
        };

        targets = {
          qtile-session = {
            description = "Qtile session";
            documentation = [ "man:systemd.special(7)" ];
            bindsTo = [ "graphical-session.target" ];
            wants = [ "graphical-session-pre.target" ];
            after = [ "graphical-session-pre.target" ];
          };

          i3-session = {
            description = "i3 session";
            documentation = [ "man:systemd.special(7)" ];
            bindsTo = [ "graphical-session-pre.target" ];
            wants = [ "graphical-session-pre.target" ];
            after = [ "graphical-session-pre.target" ];
          };
        };
      };
    }

    (lib.mkIf (config.networking.hostName == "NixOS-Rig") {
      services.xserver.deviceSection = ''
        Option "TearFree" "true"
        Option "VariableRefresh" "true"
        Option "DRI" "3"
      '';

      systemd.user.services.xrandr.serviceConfig.ExecStart =
        "${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0";
    })

    (lib.mkIf (config.networking.hostName == "NixOS-Lappie") {
      services.xserver.deviceSection = ''
        Option "TearFree" "true"
        Option "DRI" "3"
      '';

      systemd.user.services.xrandr.serviceConfig.ExecStart = 
        "${pkgs.xorg.xrandr}/bin/xrandr --output eDP --mode 1920x1080 --rate 60.00";
    })
  ];
}
