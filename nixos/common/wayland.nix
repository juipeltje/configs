# NixOS Wayland configuration

{ config, inputs, lib, pkgs, ... }:

{
  # Enable wayland compositors, Waybar, and Xwayland.
  programs = {
    river = {
      enable = true;
      package = pkgs.river;
      extraPackages = [ ];
    };

    sway = {
      enable = true;
      package = pkgs.swayfx;
      extraPackages = [ ];
    };

    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    niri = {
      enable = true;
      package = pkgs.niri;
    };

    waybar = {
      enable = true;
      package = pkgs.waybar;
    };

    xwayland.enable = true;
  };

  # xdg-desktop-portal settings
  xdg.portal.wlr.enable = lib.mkForce false;

  # Additional wayland-specific packages
  environment.systemPackages = with pkgs; [
    # Notifications
    mako

    # Run launcher
    tofi
    fuzzel

    # Wallpaper tools
    swaybg
    mpvpaper 

    # xwayland
    xwayland-satellite

    # screenlocker
    gtklock

    # Kanshi
    kanshi
  ];

  # set up pam to make sure gtklock actually works.
  security.pam.services.gtklock = { };

  # Systemd services for gtklock ( i use a screenlocker instead of a display manager),
  # Waybar, and Kanshi, and setting up Systemd targets for various compositors.
  systemd.user = {
    services = {
      gtklock = {
        enable = true;
        unitConfig = {
          Description = "Start gtklock after logging into compositor";
          PartOf = [ "sway-session.target" "river-session.target" "hyprland-session.target" "niri-session.target" ];
        };

        serviceConfig = {
          ExecStart = "${pkgs.gtklock}/bin/gtklock";
          Restart = "on-failure";
        };

        wantedBy = [ "sway-session.target" "river-session.target" "hyprland-session.target" "niri-session.target" ];
      };

      waybar = {
        enable = true;
        unitConfig = {
          PartOf = lib.mkForce [ "sway-session.target" "river-session.target" "hyprland-session.target" ];
        };

        wantedBy = lib.mkForce [ "sway-session.target" "river-session.target" "hyprland-session.target" ];
        path = with pkgs; [ bash gawk lm_sensors procps ];
      };

      kanshi = {
        enable = true;
        unitConfig = {
          Description = "Start Kanshi";
          PartOf = [ "sway-session.target" "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ];
        };

        serviceConfig = {
          ExecStart = "${pkgs.kanshi}/bin/kanshi";
          Restart = "on-failure";
        };

        wantedBy = [ "sway-session.target" "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ];
      };
    };

    targets = {
      river-session = {
        description = "River compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };

      hyprland-session = {
        description = "Hyprland compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };

      qtile-wayland-session = {
        description = "Qtile-wayland compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };

      niri-session = {
        description = "Niri compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };
    };
  };
}
