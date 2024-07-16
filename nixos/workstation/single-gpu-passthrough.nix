# NixOS workstation single gpu passthrough configuration

{ config, pkgs, ... }:

# qemu hook script for single gpu passthrough gaming vm.
let
  gaming_vm_hook = pkgs.writers.writeBash "gaming-vm-hook" ''
    # Variables
    GUEST_NAME="$1"
    OPERATION="$2"
    SUB_OPERATION="$3"

    # Run commands when the vm is started/stopped.
    if [ "$GUEST_NAME" == "win10-gaming" ]; then
      if [ "$OPERATION" == "prepare" ]; then
        if [ "$SUB_OPERATION" == "begin" ]; then
          systemctl stop greetd

          sleep 4
        
          virsh nodedev-detach pci_0000_0c_00_0
          virsh nodedev-detach pci_0000_0c_00_1
          virsh nodedev-detach pci_0000_0c_00_2
          virsh nodedev-detach pci_0000_0c_00_3

          modprobe -r amdgpu

          modprobe vfio-pci
        fi
      fi

      if [ "$OPERATION" == "release" ]; then
        if [ "$SUB_OPERATION" == "end" ]; then
          virsh nodedev-reattach pci_0000_0c_00_0
          virsh nodedev-reattach pci_0000_0c_00_1
          virsh nodedev-reattach pci_0000_0c_00_2
          virsh nodedev-reattach pci_0000_0c_00_3

          modprobe -r vfio-pci

          modprobe amdgpu

          systemctl start greetd
        fi
      fi
    fi
  '';
in

{

  virtualisation.libvirtd.hooks.qemu = {
    gaming_vm_hook = "${gaming_vm_hook}";
  };

  # blacklist i2c driver to prevent usb device from hanging when detaching the GPU
  boot.blacklistedKernelModules = [ "i2c-designware-pci" ];
}  
   
