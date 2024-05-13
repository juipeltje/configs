# NixOS workstation Alacritty config

{ config, pkgs, ... }:

{

  programs.alacritty = {
    enable = true;
    settings = {
      import = ["~/.config/alacritty/tokyo-night.toml"];
      #import = ["~/.config/alacritty/gruvbox-material-dark.toml"];

      cursor = {
        blink_interval = 500;
        unfocused_hollow = false;
        style = {
          shape = "Underline";
          blinking = "On";
        };
      };

      font = {
        size = 18.0;
      };

      font.bold = {
        family = "Mononoki Nerd Font";
        style = "Bold";
      };

      font.bold_italic = {
        family = "Mononoki Nerd Font";
        style = "Bold Italic";
      };

      font.italic = {
        family = "Mononoki Nerd Font";
        style = "Italic";
      };

      font.normal = {
        family = "Mononoki Nerd Font";
        style = "Regular";
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      window = {
        opacity = 1;
      };
    };
  };

  xdg.configFile = {
    "alacritty/tokyo-night.toml" = {
      enable = true;
      text = ''
        [colors.bright]
        black = "0x444b6a"
        blue = "0x7da6ff"
        cyan = "0x0db9d7"
        green = "0xb9f27c"
        magenta = "0xbb9af7"
        red = "0xff7a93"
        white = "0xacb0d0"
        yellow = "0xff9e64"

        [colors.normal]
        black = "0x32344a"
        blue = "0x7aa2f7"
        cyan = "0x449dab"
        green = "0x9ece6a"
        magenta = "0xad8ee6"
        red = "0xf7768e"
        white = "0x787c99"
        yellow = "0xe0af68"

        [colors.primary]
        background = "0x1a1b26"
        foreground = "0xa9b1d6"
      '';
    };

    "alacritty/gruvbox-material-dark.toml" = {
      enable = true;
      text = ''
        [colors.primary]
        background = "0x282828"
        foreground = "0xdfbf8e"

        [colors.normal]
        black = "0x665c54"
        red = "0xea6962"
        green = "0xa9b665"
        yellow = "0xe78a4e"
        blue = "0x7daea3"
        magenta = "0xd3869b"
        cyan = "0x89b482"
        white = "0xdfbf8e"

        [colors.bright]
        black = "0x928374"
        red = "0xea6962"
        green = "0xa9b665"
        yellow = "0xe3a84e"
        blue = "0x7daea3"
        magenta = "0xd3869b"
        cyan = "0x89b482"
        white = "0xdfbf8e"
      '';
    };

    "alacritty/nord.toml" = {
      enable = true;
      text = ''
        [colors.primary]
        background = "#2e3440"
        foreground = "#d8dee9"

        [colors.normal]
        black = "#3b4252"
        red = "#bf616a"
        green = "#a3be8c"
        yellow = "#ebcb8b"
        blue = "#81a1c1"
        magenta = "#b48ead"
        cyan = "#88c0d0"
        white = "#e5e9f0"

        [colors.bright]
        black = "#4c566a"
        red = "#bf616a"
        green = "#a3be8c"
        yellow = "#ebcb8b"
        blue = "#81a1c1"
        magenta = "#b48ead"
        cyan = "#8fbcbb"
        white = "#eceff4"
      '';
    };
  };
}
