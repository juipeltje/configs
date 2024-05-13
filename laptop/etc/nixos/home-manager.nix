# NixOS laptop home-manager config

{ config, pkgs, ... }:

{
  # Packages to install in the user environment
  home-manager.users.joppe = { pkgs, ... }: {
    home.packages = [ ];
    
    programs = {
      
      # Git
      git = {
        enable = true;
        userName = "juipeltje";
        userEmail = "joppe4444@outlook.com";
      };

      # Bash
      bash = {
        enable = true;
        shellAliases = {
          rebuild = "sudo nixos-rebuild boot --flake /home/joppe/repos/configs/laptop/config-files/etc/nixos/";
          rebuild-switch = "sudo nixos-rebuild switch --flake /home/joppe/repos/configs/laptop/config-files/etc/nixos/";
          update = "sudo nix flake update /home/joppe/repos/configs/laptop/config-files/etc/nixos/ && sudo nixos-rebuild switch --flake /home/joppe/repos/configs/laptop/config-files/etc/nixos/";
          cleanup = "sudo nix-collect-garbage && sudo nix-store --optimise";
          full-cleanup = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo nix-store --optimise";
          alsa-store = "alsactl --file ~/.config/asound.state store";
          do-script = "~/repos/configs/Scripts/darkorbit-afk-script.sh";
        };
        profileExtra = ''
          if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
              export MOZ_ENABLE_WAYLAND=1
          fi
        '';
      };
      
      # Alacritty
      alacritty = {
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
    };

    # Xinitrc
    home.file = { 
      ".xinitrc-i3" = {
        enable = true;
        executable = true;
        text = ''
          #!/bin/sh

          userresources=$HOME/.Xresources
          usermodmap=$HOME/.Xmodmap
          sysresources=/etc/X11/xinit/.Xresources
          sysmodmap=/etc/X11/xinit/.Xmodmap

          # merge in defaults and keymaps

          if [ -f $sysresources ]; then
              xrdb -merge $sysresources
          fi

          if [ -f $sysmodmap ]; then
              xmodmap $sysmodmap
          fi

          if [ -f "$userresources" ]; then
              xrdb -merge "$userresources"
          fi

          if [ -f "$usermodmap" ]; then
              xmodmap "$usermodmap"
          fi

          # start some nice programs

          if [ -d /etc/X11/xinit/xinitrc.d ] ; then
           for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
            [ -x "$f" ] && . "$f"
           done
           unset f
          fi

          exec i3
        '';
      };
      ".xinitrc-qtile" = {
        enable = true;
        executable = true;
        text = ''
          #!/bin/sh

          userresources=$HOME/.Xresources
          usermodmap=$HOME/.Xmodmap
          sysresources=/etc/X11/xinit/.Xresources
          sysmodmap=/etc/X11/xinit/.Xmodmap

          # merge in defaults and keymaps

          if [ -f $sysresources ]; then
              xrdb -merge $sysresources
          fi

          if [ -f $sysmodmap ]; then
              xmodmap $sysmodmap
          fi

          if [ -f "$userresources" ]; then
              xrdb -merge "$userresources"
          fi

          if [ -f "$usermodmap" ]; then
              xmodmap "$usermodmap"
          fi

          # start some nice programs

          if [ -d /etc/X11/xinit/xinitrc.d ] ; then
           for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
            [ -x "$f" ] && . "$f"
           done
           unset f
          fi

          exec qtile start
        '';
      };
    };
    
    # Theme settings
    home.pointerCursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    gtk = {
      enable = true;
      font.package = pkgs.nerdfonts;
      font.name = "Ubuntu Nerd Font Medium";
      font.size = 11;
      theme.package = pkgs.tokyonight-gtk-theme;
      theme.name = "Tokyonight-Dark-BL";
      iconTheme.package = pkgs.cinnamon.mint-y-icons;
      iconTheme.name = "Mint-Y-Aqua";

    };

    qt = {
      enable = true;
      platformTheme = "gtk";
      style.package = pkgs.libsForQt5.qtstyleplugins;
      style.name = "gtk2";
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}
