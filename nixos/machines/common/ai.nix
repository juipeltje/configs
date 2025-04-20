# NixOS AI configuration

{ config, lib, pkgs, ... }:

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
    description = "Ollama serve";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    environment = lib.mkIf (config.networking.hostName == "NixOS-Rig") { HSA_OVERRIDE_GFX_VERSION = "10.3.0"; };
    serviceConfig = {
      ExecStart = "${pkgs.ollama-rocm}/bin/ollama serve";
      Restart = "on-failure";
    };
  };
}
