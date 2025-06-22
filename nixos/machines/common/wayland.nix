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

    maomaowm = {
      enable = true;
    };

    niri = {
      enable = true;
      package = pkgs.niri;
    };

    wayland.miracle-wm = {
      enable = true;
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
    # compositors
    mwc_git
    
    # Terminal
    foot

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
    gtklock-powerbar-module
    gtklock-playerctl-module

    # Kanshi
    kanshi
  ];

  # set up pam to make sure gtklock actually works.
  security.pam.services.gtklock = { };

  # Systemd services for gtklock, Waybar, Kanshi, and Swayidle, and setting up Systemd targets for various compositors.
  systemd.user = {
    services = {
      gtklock = {
        enable = true;
        description = "gtklock screenlocker";
        partOf = [ "sway-session.target" "river-session.target" "hyprland-session.target" "maomao-session.target" "mwc-session.target" "niri-session.target" "dwl-session.target" ];
        wantedBy = [ "sway-session.target" "river-session.target" "hyprland-session.target" "maomao-session.target" "mwc-session.target" "niri-session.target" "dwl-session.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.gtklock}/bin/gtklock --follow-focus";
          Restart = "on-failure";
        };
      };

      waybar = {
        enable = true;
        partOf = lib.mkForce [ "sway-session.target" "river-session.target" "hyprland-session.target" "maomao-session.target" "mwc-session.target" "niri-session.target" "dwl-session.target" ];
        wantedBy = lib.mkForce [ "sway-session.target" "river-session.target" "hyprland-session.target" "maomao-session.target" "mwc-session.target" "niri-session.target" "dwl-session.target" ];
        path = with pkgs; [ bash curl gawk lm_sensors mwc_git procps ];
      };

      kanshi = {
        enable = true;
        description = "Kanshi display configuration daemon";
        partOf = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        unitConfig = {
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };

        serviceConfig = {
          ExecStart = "${pkgs.kanshi}/bin/kanshi";
          Restart = "on-failure";
        };
      };

      swayidle = {
        enable = true;
        description = "Swayidle idle manager for Wayland";
        documentation = [ "man:swayidle(1)" ];
        partOf = [ "sway-session.target" "river-session.target" "hyprland-session.target" "maomao-session.target" "mwc-session.target" "niri-session.target" "dwl-session.target" ];
        wantedBy = [ "sway-session.target" "river-session.target" "hyprland-session.target" "maomao-session.target" "mwc-session.target" "niri-session.target" "dwl-session.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.swayidle}/bin/swayidle -w";
          Restart = "on-failure";
        };
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

      maomao-session = {
        description = "maomaowm compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };

      mwc-session = {
        description = "mwc compositor session";
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

      dwl-session = {
        description = "DWL compositor session";
        documentation = [ "man:systemd.special(7)" ];
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
      };
    };
  };
}
