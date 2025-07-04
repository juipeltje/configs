# Home Manager driver configuration

{ config, lib, nixgl, pkgs, ... }:

{
  home.packages = with pkgs; [
    nixgl.packages.${pkgs.system}.nixGLIntel
    nixgl.packages.${pkgs.system}.nixVulkanIntel
    (
      let
        driversEnv = pkgs.buildEnv {
          name = "graphics-drivers";
          paths = with pkgs; [ mesa.drivers rocmPackages.clr.icd ];
        };

        driversEnv32 = pkgs.buildEnv {
          name = "graphics-drivers-32bit";
          paths = with pkgs1686Linux; [ mesa.drivers ];
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