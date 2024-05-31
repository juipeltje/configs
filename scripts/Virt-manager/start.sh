#!/usr/bin/env bash
# Helpful to read output when debugging
set -x

# stop display manager and user processes.
systemctl stop greetd
# pkill -u joppe
# killall sway 

# Unbind VTconsoles: might not be needed
# echo 0 > /sys/class/vtconsole/vtcon0/bind
# echo 0 > /sys/class/vtconsole/vtcon1/bind

# Avoid a race condition by waiting a couple of seconds. This can be calibrated to be shorter or longer if required for your system
sleep 4

# Unbind EFI Framebuffer
# echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Unload AMD kernel module
modprobe -r amdgpu

# Detach GPU devices from host
# virsh nodedev-detach pci_0000_09_00_0
# virsh nodedev-detach pci_0000_0a_00_0
virsh nodedev-detach pci_0000_0c_00_0
virsh nodedev-detach pci_0000_0c_00_1
virsh nodedev-detach pci_0000_0c_00_2
virsh nodedev-detach pci_0000_0c_00_3
# echo "0000:0c:00.3" > /sys/bus/pci/devices/0000:0c:00.3/driver/unbind

# Load vfio module
modprobe vfio-pci
