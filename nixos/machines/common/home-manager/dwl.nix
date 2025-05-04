# Home Manager DWL configuration

{ config, hostName, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    {
      home.packages = with pkgs; [
        dwl
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

    #(lib.mkIf (hostName == "NixOS-Lappie") {
    #  xdg.configFile."kanshi/config".source = ./../../../../dotfiles/laptop/dotconfig/kanshi/config;
    #})
  ];
}
