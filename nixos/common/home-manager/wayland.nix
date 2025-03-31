# NixOS Wayland settings

{ config, pkgs, ... }:

{
  # create swaybg and mako systemd service.
  systemd.user.services = {
    swaybg = {
      Unit = {
        Description = "Set compositor background with swaybg";
        PartOf = [ "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ];
      };

      Install = { WantedBy = [ "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ]; };
      Service = { 
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/Pictures/sway/background.jpg -m fill"; 
        Restart = "on-failure";
      };
    };

    mako = {
      Unit = {
        Description = "Start Mako notification daemon";
        PartOf = [ "sway-session.target" "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ];
      };

      Install = { WantedBy = [ "sway-session.target" "river-session.target" "hyprland-session.target" "qtile-wayland-session.target" "niri-session.target" ]; };
      Service = {
        ExecStart = "${pkgs.mako}/bin/mako -c ${config.home.homeDirectory}/.config/mako/gruvbox-dark-config";
        Restart = "on-failure";
      };
    };
  };
}                   
      
