#!/bin/bash

# Disable swap and add kernel settings
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab

# Add kernel settings & enable IP tables (CNI prerequisites)
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# Load modules
modprobe overlay
modprobe br_netfilter

# Apply sysctl settings without reboot
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Reload sysctl settings
sysctl --system

# Install containerd runtime
# Update the package index
sudo apt-get update -y
# Install prerequisites
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s GPG key and repository for containerd
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Setup the Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index with the new repository and install containerd
sudo apt-get update -y
sudo apt-get install -y containerd.io

# Generate default configuration file for containerd and configure cgroup as systemd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

# Restart and enable containerd service
sudo systemctl restart containerd
sudo systemctl enable containerd

# Installing kubeadm, kubelet, and kubectl
# Update the apt package index and install packages needed to use the Kubernetes apt repository
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

# Download the public signing key for the Kubernetes package repositories
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the Kubernetes apt repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update the apt package index with the new repository
sudo apt-get update

# Install the required packages
sudo apt-get install -y kubelet kubeadm kubectl

# Prevent automatic updates of Kubernetes packages
sudo apt-mark hold kubelet kubeadm kubectl

# Enable and start kubelet service
sudo systemctl daemon-reload
sudo systemctl start kubelet
sudo systemctl enable kubelet.service

# Initialize Kubernates master by executing below commond.
kubeadm init