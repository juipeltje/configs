# NixOS workstation Bash config

{ config, pkgs, ... }:

{

  programs.bash = {
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
}
