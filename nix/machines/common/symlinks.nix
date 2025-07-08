# Home Manager symlink configuration

{ config, lib, pkgs, ... }:

{
  home.activation = {
    Symlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      # Desktop shortcuts
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/mkdir -p $VERBOSE_ARG \
        ${config.home.homeDirectory}/.local/share/applications
      
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
        ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.home.homeDirectory}/.local/share/applications

      # Themes
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/mkdir -p $VERBOSE_ARG \
        ${config.home.homeDirectory}/.local/share/themes
      $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
        ${config.home.homeDirectory}/.nix-profile/share/themes/* ${config.home.homeDirectory}/.local/share/themes
    '';
  };
}
      
