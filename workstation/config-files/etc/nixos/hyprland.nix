# NixOS workstation Hyprland configs

{ config, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # monitor settings
      monitor = "DP-1,3440x1440@165,0x1080,1";
      monitor = "DP-2,2560x1080@75,0x0,1";

      # Execute your favorite apps at launch
      exec-once = [ "~/.config/hypr/autostart.sh" ];
    
      # environment variables

      # set the cursor size
      env = [ "XCURSOR_SIZE,24" ];

      input {
        kb_layout = us;
        follow_mouse = 1;
        sensitivity = 0;
      };

      general {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 4;

        # color themes
        # Gruvbox-Material
        # col.active_border = rgb(dfbf8e)
        # col.inactive_border = rgb(665c54)
        # Nordic
        # col.active_border = rgb(8fbcbb)
        # col.inactive_border = rgb(4c566a)
        # Tokyo-Night
        "col.active_border" = "rgb(a9b1d6)";
        "col.inactive_border" = "rgb(565f89)";

        # which layout to use
        layout = master;
}
