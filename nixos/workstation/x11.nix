# NixOS workstation X11 configuration

{ config, pkgs, ... }:

{

  # X11 videodriver config for workstation.
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
      Option "VariableRefresh" "true"
      Option "DRI" "3"
    '';
  };
}
