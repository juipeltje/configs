# Home Manager symlink configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      home.activation = {
        CommonSymlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          # bash_profile
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/.bash_profile ${config.home.homeDirectory}/
        '';
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      home.activation = {
        WorkstationSymlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          # Waybar
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/workstation/dotconfig/waybar/config ${config.home.homeDirectory}/.config/waybar/
        '';
      };
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      home.activation = {
        LaptopSymlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          # Waybar
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/laptop/dotconfig/waybar/config ${config.home.homeDirectory}/.config/waybar/
        '';
      };
    })
  ];
}
      
