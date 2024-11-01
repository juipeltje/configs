# NixOS custom qcma module

{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.programs.qcma;
in

{
  options.programs.qcma = {
    enable = mkEnableOption "Enable qcma, a content manager assistant for PS Vita";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ (libsForQt5.callPackage ./../derivations/qcma/qcma.nix { }) ];
    services.udev.packages = with pkgs; [ (callPackage ./../derivations/qcma/libvitamtp-udev.nix { }) ];
  };
}
    
    
