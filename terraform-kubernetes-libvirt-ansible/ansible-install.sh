#!/bin/bash

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y software-properties-common

# Add Ansible repository
sudo apt-add-repository --yes --update ppa:ansible/ansible

# Install Python and pip
sudo apt install -y python3 python3-pip

# Install Ansible
sudo apt install -y ansible

# Verify installation
ansible --version
