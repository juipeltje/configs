# NixOS workstation home-manager config

{ config, pkgs, ... }:

{
  # Packages to install in the user environment
  home-manager.users.joppe = { pkgs, ... }: {
    home.packages = [ ];
    imports = [
      ./alacritty.nix
    ];
    
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
          rebuild = "sudo nixos-rebuild boot --flake /home/joppe/repos/configs/workstation/config-files/etc/nixos/";
          rebuild-switch = "sudo nixos-rebuild switch --flake /home/joppe/repos/configs/workstation/config-files/etc/nixos/";
          update = "sudo nix flake update /home/joppe/repos/configs/workstation/config-files/etc/nixos/ && sudo nixos-rebuild switch --flake /home/joppe/repos/configs/workstation/config-files/etc/nixos/";
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

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };



    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}
