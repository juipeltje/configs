# Home Manager Wayland configuration

{ config, hostName, inputs, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      # Install wayland related packages
      home.packages = with pkgs; [
        # Compositors
        dwl
        river
        swayfx
        hyprland
        niri
        inputs.maomaowm.packages.x86_64-linux.maomaowm
        mwc_git

        # Terminal
        foot

        # Bar
        waybar

        # Notifications
        mako

        # Run launcher
        tofi
        fuzzel

        # Wallpaper tools
        swaybg
        mpvpaper

        # Xwayland
        xwayland
        xwayland-satellite

        # gtklock modules
        gtklock-powerbar-module
        gtklock-playerctl-module

        # Display configuration
        kanshi
        swayidle
      ];

      # writing gtklock config.ini inside of nix in order to reference the module paths in the store
      xdg.configFile = {
        "gtklock/config.ini" = {
          enable = true;
          text = ''
            [main]
            modules=${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so;${pkgs.gtklock-playerctl-module}/lib/gtklock/playerctl-module.so
            time-format=  %H:%M
            date-format=  %A, %d %B

            [playerctl]
            position=bottom-center
          '';
        };
      };

      # dwl patching
      nixpkgs.overlays = [
        (final: prev: {
          dwl = prev.dwl.overrideAttrs (finalAttrs: previousAttrs: {
            patches = [
              ./../../../dotfiles/common/dotconfig/dwl/patches/alwayscenter.patch
              ./../../../dotfiles/common/dotconfig/dwl/patches/attachbottom.patch
              ./../../../dotfiles/common/dotconfig/dwl/patches/autostart-0.7.patch
              ./../../../dotfiles/common/dotconfig/dwl/patches/ipc.patch
              ./../../../dotfiles/common/dotconfig/dwl/patches/restore-monitor.patch
              #./../../../dotfiles/common/dotconfig/dwl/patches/simple_scratchpad-v0.7.patch
              ./../../../dotfiles/common/dotconfig/dwl/patches/vanitygaps-0.7.patch
              ./../../../dotfiles/common/dotconfig/dwl/patches/warpcursor.patch
            ];
          });
        })
      ];
    }

    (lib.mkIf (hostName == "Void-Rig") {
      nixpkgs.overlays = [
        (final: prev: {
          dwl = prev.dwl.override {
            configH = ./../../../dotfiles/workstation/dotconfig/dwl/config.h;
          };
        })
      ];
    })

    (lib.mkIf (hostName == "Void-Lappie") {
      nixpkgs.overlays = [
        (final: prev: {
          dwl = prev.dwl.override {
            configH = ./../../../dotfiles/laptop/dotconfig/dwl/config.h;
          };
        })
      ];
    })
  ];
}
