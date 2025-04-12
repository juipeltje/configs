# Home Manager symlink configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      home.activation = {
        CommonSymlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          # Alacritty
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/alacritty/alacritty.toml ${config.home.homeDirectory}/.config/alacritty/

          # bash_profile
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/.bash_profile ${config.home.homeDirectory}/

          # Fuzzel
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/fuzzel/fuzzel.ini ${config.home.homeDirectory}/.config/fuzzel/

          # gtklock
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/gtklock/style.css ${config.home.homeDirectory}/.config/gtklock/

          # Hyprland
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/hypr/common.conf ${config.home.homeDirectory}/.config/hypr/

          # i3
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/i3/common.conf ${config.home.homeDirectory}/.config/i3/

          # Kitty
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/kitty/kitty.conf ${config.home.homeDirectory}/.config/kitty/

          # Qtile
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/qtile/common.py ${config.home.homeDirectory}/.config/qtile/

          # River
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/river/common.sh ${config.home.homeDirectory}/.config/river/

          # Rofi
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/rofi/config.rasi ${config.home.homeDirectory}/.config/rofi/

          # SwayFX
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/sway/common.conf ${config.home.homeDirectory}/.config/sway/

          # Waybar
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/common/dotconfig/waybar/style.css ${config.home.homeDirectory}/.config/waybar/
        '';
      };
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      home.activation = {
        WorkstationSymlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          # Niri
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/workstation/dotconfig/niri/config.kdl ${config.home.homeDirectory}/.config/niri/

          # Waybar
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/workstation/dotconfig/waybar/config ${config.home.homeDirectory}/.config/waybar/
        '';
      };
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      home.activation = {
        LaptopSymlinks = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          # Niri
          #$DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
          #  ${config.home.homeDirectory}/repos/configs/dotfiles/laptop/dotconfig/niri/config.kdl ${config.home.homeDirectory}/.config/niri/

          # Waybar
          $DRY_RUN_CMD ${pkgs.coreutils}/bin/ln -sf $VERBOSE_ARG \
            ${config.home.homeDirectory}/repos/configs/dotfiles/laptop/dotconfig/waybar/config ${config.home.homeDirectory}/.config/waybar/
        '';
      };
    })
  ];
}
      
