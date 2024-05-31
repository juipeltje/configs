#!/usr/bin/env bash
# Helpful to read output when debugging
set -x

# Attach GPU devices to host
# virsh nodedev-reattach pci_0000_09_00_0
# virsh nodedev-reattach pci_0000_0a_00_0
virsh nodedev-reattach pci_0000_0c_00_0
virsh nodedev-reattach pci_0000_0c_00_1
virsh nodedev-reattach pci_0000_0c_00_2
virsh nodedev-reattach pci_0000_0c_00_3

# Unload vfio module
modprobe -r vfio-pci

# Load AMD kernel module
modprobe amdgpu

# Rebind EFI Framebuffer to host
# echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

# Bind VTconsoles: might not be needed
# echo 1 > /sys/class/vtconsole/vtcon0/bind
# echo 1 > /sys/class/vtconsole/vtcon1/bind

# Restart display manager
systemctl start greetd
