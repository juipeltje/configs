# Home Manager NixGL configuration

{ config, lib, nixgl, pkgs, ... }:

{
  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
}