# NixOS workstation liquidctl config

{ config, pkgs, ... }:

{
  # install custom yoda derivation with liquidctl and dependencies.
  environment.systemPackages = with pkgs; [
    (python3.withPackages (subpkgs: with subpkgs; [ 
      (python3Packages.callPackage ./derivations/yoda/derivation.nix { })
    ]))
  ];

  # Systemd service to initialize liquidctl and set yoda fancurve at boot.
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
        (python3Packages.callPackage ./derivations/yoda/derivation.nix { })
      ])) 
    ];

    script = ''
      liquidctl initialize all
      sleep 2
      liquidctl --match kraken set pump speed 100
      yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl
    '';
  };
}
