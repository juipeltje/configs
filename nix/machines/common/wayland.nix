# Home Manager Wayland configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Install wayland related packages
      home.packages = with pkgs; [
        # Compositors
        river
        dwl

        # Xwayland
        xwayland
        xwayland-satellite
      ];

      nixpkgs.overlays = [
        (final: prev: {
          dwl = prev.dwl.overrideAttrs (finalAttrs: previousAttrs: {
            patches = [
              ./../../../../dotfiles/common/dotconfig/dwl/patches/alwayscenter.patch
              ./../../../../dotfiles/common/dotconfig/dwl/patches/attachbottom.patch
              ./../../../../dotfiles/common/dotconfig/dwl/patches/autostart-0.7.patch
              ./../../../../dotfiles/common/dotconfig/dwl/patches/ipc.patch
              ./../../../../dotfiles/common/dotconfig/dwl/patches/restore-monitor.patch
              #./../../../../dotfiles/common/dotconfig/dwl/patches/simple_scratchpad-v0.7.patch
              ./../../../../dotfiles/common/dotconfig/dwl/patches/vanitygaps-0.7.patch
              ./../../../../dotfiles/common/dotconfig/dwl/patches/warpcursor.patch
            ];
          });
        })
      ];
    }

    (lib.mkIf (hostName == "NixOS-Rig") {
      nixpkgs.overlays = [
        (final: prev: {
          dwl = prev.dwl.override {
            configH = ./../../../../dotfiles/workstation/dotconfig/dwl/config.h;
          };
        })
      ];
    })

    (lib.mkIf (hostName == "NixOS-Lappie") {
      nixpkgs.overlays = [
        (final: prev: {
          dwl = prev.dwl.override {
            configH = ./../../../../dotfiles/laptop/dotconfig/dwl/config.h;
          };
        })
      ];
    })
  ];
}
