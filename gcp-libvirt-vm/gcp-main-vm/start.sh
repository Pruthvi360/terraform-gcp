#!/bin/bash

set -x

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install required packages
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

# Add the current user to the libvirt group
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG libvirt root

# Enable and start libvirtd service
sudo systemctl enable libvirtd
sudo systemctl start libvirtd

# Configure the default network
sudo virsh net-autostart default
sudo virsh net-start default

# Enable nested virtualization (if supported)
if grep -q "vmx\|svm" /proc/cpuinfo; then
    sudo modprobe -r kvm_intel
    sudo modprobe -r kvm
    sudo modprobe -r kvm_amd
    sudo modprobe kvm_intel nested=1
fi

grep -cw vmx /proc/cpuinfo

# Download the latest version of Terraform
wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip

# Install required packages
sudo apt update
sudo apt install -y curl unzip

sudo unzip terraform_1.5.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
sudo chmod 755 /usr/local/bin/terraform

sudo usermod -aG kvm,libvirt $USER
sudo echo 'security_driver = [ "none" ]'> /etc/libvirt/qemu.conf
sudo systemctl restart libvirtd


terraform --version

wget https://storage.googleapis.com/terraform-libvirt/main.tf

cp main.tf /home
terraform init
terraform apply -auto-approve

# Reboot the system for changes to take effect

# reboot