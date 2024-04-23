# NixOS yazi config

{ config, pkgs, ... }:

{

  programs.yazi = {
    enable = true;
    keymap = {
      manager.append_keymap = [
        { exec = "shell --confirm 'swaymsg output \"*\" background $0 fill && cp -f $0 ~/Pictures/sway/background.jpg'"; on = [ "<C-w>" ]; }
      ];
    };

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "alphabetical";
        sort_dir_first = true;
      };
    };
  };
}
