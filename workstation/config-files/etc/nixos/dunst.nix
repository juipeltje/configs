# NixOS Dunst config

{ config, pkgs, ... }:

{

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Mint-Y-Sand";
      package = pkgs.cinnamon.mint-y-icons;
      size = "32x100";
    };
    
    settings = {
      global = {
        width = 300;
        height = 150;
        origin = "top-right";
        offset = "10x58";
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 4;
        # Nordic
        # frame_color = "#d8dee9"
        # Gruvbox-Material
        # frame_color = "#dfbf8e"
        # Tokyo-Night
        frame_color = "#a9b1d6";
        font = "Ubuntu Nerd Font Medium 11";
        alignment = "left";
        vertical_alignment = "center";
        icon_position = "left";
        history_length = 20;
        corner_radius = 10;
      };
      
      urgency_low = {
        # Nordic
        # background = "#2e3440"
        # foreground = "#d8dee9"
        # Gruvbox-Material
        # background = "#282828"
        # foreground = "#dfbf8e"
        # Tokyo-Night
        background = "#1a1b26";
        foreground = "#a9b1d6";
        timeout = 5;
      };
      
      urgency_normal = {
        # Nordic
        # background = "#2e3440"
        # foreground = "#d8dee9"
        # Gruvbox-Material
        # background = "#282828"
        # foreground = "#dfbf8e"
        # Tokyo-Night
        background = "#1a1b26";
        foreground = "#a9b1d6";
        timeout = 5;
      };
      
      urgency_critical = {
        # Nordic
        # background = "#2e3440"
        # foreground = "#d8dee9"
        # frame_color = "#bf616a"
        # Gruvbox-Material
        # background = "#282828"
        # foreground = "#dfbf8e"
        # frame_color = "#ea6962"
        # Tokyo-Night
        background = "#1a1b26";
        foreground = "#a9b1d6";
        frame_color = "#f7768e";
        timeout = 5;
      };
    };
  };
}

