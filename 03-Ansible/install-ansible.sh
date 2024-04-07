#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install software-properties-common if not already installed
echo "Installing software-properties-common..."
sudo apt install -y software-properties-common

# Add the Ansible PPA
echo "Adding Ansible PPA..."
sudo add-apt-repository --yes ppa:ansible/ansible

# Update the package list again
echo "Updating package list..."
sudo apt update

# Install Ansible
echo "Installing Ansible..."
sudo apt install -y ansible

# Verify the installation
echo "Ansible version:"
ansible --version
