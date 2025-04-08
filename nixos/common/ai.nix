# NixOS Workstation AI config

{ config, pkgs, ... }:

{
  # Enable OpenCL (ROCM)
  hardware.amdgpu.opencl.enable = true;

  # Install ollama-rocm.
  environment.systemPackages = with pkgs; [
    ollama-rocm
  ];

  # create ollama systemd user service
  systemd.user.services.ollama = {
    enable = true;
    unitConfig = {
      Description = "Start ollama serve";
      After = [ "network.target" ];
    };

    serviceConfig = {
      ExecStart = "${pkgs.ollama-rocm}/bin/ollama serve";
      Restart = "on-failure";
    };

    environment = if "${config.networking.hostName}" == "NixOS-Rig" then { HSA_OVERRIDE_GFX_VERSION = "10.3.0"; } else { };
    wantedBy = [ "default.target" ];
  };
}
