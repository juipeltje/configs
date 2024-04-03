# NixOS workstation home-manager config

{ config, pkgs, ... }:

{
  # Home-manager settings
  home-manager.users.joppe = { pkgs, ... }: {
    home.packages = [ ];

    programs = {
      git = {
        enable = true;
        userName = "juipeltje";
        userEmail = "joppe4444@outlook.com";
      };

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
    };

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
