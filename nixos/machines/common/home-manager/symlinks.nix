# Home Manager symlink configuration

{ config, lib, pkgs, ... }:

{
  home.activation = {
    CommonSymlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      # bash_profile
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
        ${config.home.homeDirectory}/repos/configs/dotfiles/common/.bash_profile ${config.home.homeDirectory}/

      # Waybar
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
        ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/waybar/common ${config.home.homeDirectory}/.config/waybar/
    '';
  };
}
      
