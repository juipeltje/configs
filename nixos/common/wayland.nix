# NixOS Wayland configuration

{ config, lib, pkgs, ... }:

{
  # Enable wayland compositors and Xwayland.
  programs = {
    river = {
      enable = true;
      extraPackages = [ ];
    };

    sway = {
      enable = true;
      package = pkgs.swayfx;
      extraPackages = [ ];
    };

    hyprland.enable = true;
    niri.enable = true;
    xwayland.enable = true;
  };

  # Additional wayland-specific packages
  environment.systemPackages = with pkgs; [
    # Bar
    waybar

    # Notifications
    mako

    # Run launcher
    tofi
    fuzzel

    # Wallpaper tools
    swaybg
    hyprpaper
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
  # Waybar, and Kanshi.
  systemd.user.services = {
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
        Description = "Start Waybar";
        PartOf = [ "sway-session.target" "river-session.target" "hyprland-session.target" ];
      };

      serviceConfig = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
      };

      wantedBy = [ "sway-session.target" "river-session.target" "hyprland-session.target" ];
      path = with pkgs; [ bash gawk lm_sensors procps ];
    };

    kanshi = {
      enable = true;
      unitConfig = {
        Description = "Start Kanshi for River and Qtile-wayland compositors";
        PartOf = [ "river-session.target" "qtile-wayland-session.target" ];
      };

      serviceConfig = {
        ExecStart = "${pkgs.kanshi}/bin/kanshi";
        Restart = "on-failure";
      };

      wantedBy = [ "river-session.target" "qtile-wayland-session.target" ];
    };
  };

  # xdg-desktop-portal settings
  xdg.portal.wlr.enable = lib.mkForce false;

  # set up systemd targets for River, Hyprland, and Qtile-wayland.
  systemd.user.targets = {
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
}
