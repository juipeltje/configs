# NixOS custom Yoda module

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.hardware.yoda;
in

{
  options.services.hardware.yoda = {
    enable = mkEnableOption "Yoda, a fan curve script written in python utilizing liquidctl.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (python3.withPackages (subpkgs: with subpkgs; [ 
        (callPackage ./../derivations/yoda/derivation.nix { })
      ]))
    ];

    systemd.services = {
      yoda = {
        description = "Liquidctl and Yoda fancurve";
        partOf = [ "multi-user.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Restart = "always";
        path = with pkgs; [ 
          (python3.withPackages (subpkgs: with subpkgs; [ 
            (callPackage ./../derivations/yoda/derivation.nix { })
          ])) 
        ];

        script = ''
          liquidctl initialize all
          sleep 2
          liquidctl --match kraken set pump speed 100
          yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl
        '';
      };

      yoda-stop = {
        description = "Stop Liquidctl and Yoda fancurve before going to sleep";
        before = [ "sleep.target" ];
        wantedBy = [ "sleep.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.procps}/bin/pkill yoda";
          Restart = "on-failure";
        };
      };
    };
  };
}
    
    
