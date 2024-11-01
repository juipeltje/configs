# NixOS workstation virtualisation configuration

{ config, pkgs, ... }:

{
  # Enable virt-manager and libvirtd daemon.
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # Add users to the libvirt and kvm groups.
  users.users.joppe.extraGroups = [ "libvirtd" ];

  # Enable IOMMU and isolate Nvidia GT730 GPU with vfio.
  boot = {
    kernelParams = [ "amd_iommu=on" "iommu=pt" ];
    kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];
    extraModprobeConfig = "options vfio-pci ids=10de:1287,10de:0e0f";
  };
}
