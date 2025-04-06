# NixOS Workstation AI config

{ config, pkgs, ... }:

{
  # Enable OpenCL (ROCM)
  hardware.amdgpu.opencl.enable = true;

  # Install ollama-rocm.
  environment.systemPackages = with pkgs; [
    ollama-rocm
  ];
}
