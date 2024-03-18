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

# Step 7: Initialize Kubernetes Master Node
echo "Initializing Kubernetes Master Node..."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Step 8: Configure Kubernetes Cluster
echo "Configuring Kubernetes cluster..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Step 9: Deploy Networking Solution (Calico)
echo "Deploying Calico network..."
kubectl apply -f https://docs.projectcalico.org/v3.20/manifests/calico.yaml

# Step 10: Deploy Ingress Controller (NGINX)
echo "Deploying NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml

echo "Master node setup complete."
