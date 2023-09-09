#!/bin/bash
# Helpful to read output when debugging
set -x

# stop display manager
systemctl stop lightdm.service

# Unbind VTconsoles: might not be needed
# echo 0 > /sys/class/vtconsole/vtcon0/bind
# echo 0 > /sys/class/vtconsole/vtcon1/bind

# Avoid a race condition by waiting a couple of seconds. This can be calibrated to be shorter or longer if required for your system
sleep 4

# Unbind EFI Framebuffer
# echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Detach GPU devices from host
# virsh nodedev-detach pci_0000_09_00_0
# virsh nodedev-detach pci_0000_0a_00_0
virsh nodedev-detach pci_0000_0b_00_0
virsh nodedev-detach pci_0000_0b_00_1
virsh nodedev-detach pci_0000_0b_00_2
virsh nodedev-detach pci_0000_0b_00_3

# Unload AMD kernel module
modprobe -r amdgpu

# Load vfio module
modprobe vfio-pci
