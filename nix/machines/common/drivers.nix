# Home Manager driver configuration

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (
      let
        driversEnv = pkgs.buildEnv {
          name = "graphics-drivers";
          paths = with pkgs; [ mesa rocmPackages.clr.icd ];
        };

        driversEnv32 = pkgs.buildEnv {
          name = "graphics-drivers-32bit";
          paths = with pkgsi686Linux; [ mesa ];
        };
      in pkgs.runCommand "graphics-drivers" {} ''
        mkdir -p $out/drivers
        cd $out/drivers
        ln -s "${toString driversEnv}" opengl-driver
        ln -s "${toString driversEnv32}" opengl-driver-32
      ''
    )
  ];
}