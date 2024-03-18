#!/bin/bash

# Step 1: Update System Packages
echo "Updating system packages..."
sudo apt-get update

# Step 2: Install Docker
echo "Installing Docker..."
sudo apt install docker.io -y
sudo chmod 666 /var/run/docker.sock

# Step 3: Install Required Dependencies for Kubernetes
echo "Installing required dependencies for Kubernetes..."
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
sudo mkdir -p -m 755 /etc/apt/keyrings

# Step 4: Add Kubernetes Repository and GPG Key
echo "Adding Kubernetes repository and GPG Key..."
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Step 5: Update Package List
echo "Updating package list..."
sudo apt update

# Step 6: Install Kubernetes Components
echo "Installing Kubernetes components..."
sudo apt install -y kubeadm=1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1

echo "Installation complete."
