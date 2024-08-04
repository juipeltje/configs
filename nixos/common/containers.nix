# NixOS workstation container configuration

{ config, pkgs, ... }:

{

  virtualisation = {
    podman.enable = true;
    oci-containers.backend = "podman";
    oci-containers.containers = {
      ArchBox = {
        image = "library/archlinux";
        autoStart = true;
        user = "joppe";
        hostname = "archbox";
        environment = { DISPLAY = "$DISPLAY"; };
        extraOptions = [ "--network=host" ];
        volumes = [
          "/tmp/.X11-unix:/tmp/.X11-unix"
          "/home/joppe/AppImages:/home/joppe/AppImages"
        ];
      };
    };
  };
}
        
