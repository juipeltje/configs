# NixOS custom Yoda module

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.hardware.yoda;
in

{
  options.services.hardware.yoda = {
    enable = mkEnableOption "Enable Yoda, a fan curve script written in python utilizing liquidctl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (python3.withPackages (subpkgs: with subpkgs; [ 
        (python3Packages.callPackage ./../derivations/yoda/derivation.nix { })
      ]))
    ];

    systemd.services.yoda = {
      unitConfig = {
        Description = "Service to initialize liquidctl and set yoda fancurve.";
      };

      serviceConfig = {
        Type = "simple";
      };

      wantedBy = [ "default.target" ];

      path = with pkgs; [ 
        (python3.withPackages (subpkgs: with subpkgs; [ 
          (python3Packages.callPackage ./../derivations/yoda/derivation.nix { })
        ])) 
      ];

      script = ''
        liquidctl initialize all
        sleep 2
        liquidctl --match kraken set pump speed 100
        yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl
      '';
    };
  };
}
    
    
