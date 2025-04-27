# NixOS workstation gpu passthrough configuration

{ config, pkgs, ... }:

# qemu hook script for gpu passthrough vm.
let
  vm_hook = pkgs.writers.writeBash "vm-hook" ''
    # Variables
    GUEST_NAME="$1"
    OPERATION="$2"
    SUB_OPERATION="$3"

    # Run commands when the vm is started/stopped.
    if [ "$GUEST_NAME" == "win11-nvidia" ]; then
      if [ "$OPERATION" == "prepare" ]; then
        if [ "$SUB_OPERATION" == "begin" ]; then
          systemctl set-property --runtime -- user.slice AllowedCPUs=0,8,1,9,2,10,3,11
          systemctl set-property --runtime -- system.slice AllowedCPUs=0,8,1,9,2,10,3,11
          systemctl set-property --runtime -- init.scope AllowedCPUs=0,8,1,9,2,10,3,11
        fi
      fi

      if [ "$OPERATION" == "release" ]; then
        if [ "$SUB_OPERATION" == "end" ]; then
          systemctl set-property --runtime -- user.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- system.slice AllowedCPUs=0-15
          systemctl set-property --runtime -- init.scope AllowedCPUs=0-15
        fi
      fi
    fi
  '';
in

{
  virtualisation.libvirtd.hooks.qemu = {
    vm_hook = "${vm_hook}";
  };
}  
   
