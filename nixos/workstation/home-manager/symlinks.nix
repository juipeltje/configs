# NixOS workstation symlink configs

{ config, lib, pkgs, ... }:

{
  home.activation = {
    WorkstationSymlinks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Niri
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
        ${config.home.homeDirectory}/repos/configs/workstation/home/dotconfig/niri/config.kdl ${config.home.homeDirectory}/.config/niri/

      # Waybar
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
        ${config.home.homeDirectory}/repos/configs/workstation/home/dotconfig/waybar/config ${config.home.homeDirectory}/.config/waybar/
    '';
  };
}
      
