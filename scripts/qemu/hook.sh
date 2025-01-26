#!/usr/bin/env bash

# qemu hook script for passing through gpu when gaming vm is started, and reverting when vm is shutdown.

# Variables
GUEST_NAME="$1"
OPERATION="$2"
SUB_OPERATION="$3"

# Run commands when the vm is started/stopped.
if [ "$GUEST_NAME" == "win10-gaming" ]; then
  if [ "$OPERATION" == "prepare" ]; then
    if [ "$SUB_OPERATION" == "begin" ]; then
	sv down greetd

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

	sv up greetd
    fi
  fi
fi
