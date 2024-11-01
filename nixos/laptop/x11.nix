# NixOS laptop X11 configuration

{ config, pkgs, ... }:

{
  # X11 videodriver config for laptop.
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "TearFree" "true"
      Option "DRI" "3"
    '';
  };

  # Configure laptop touchpad.
  services.libinput.touchpad.additionalOptions = ''
    Option "Tapping" "on"
  '';
}
