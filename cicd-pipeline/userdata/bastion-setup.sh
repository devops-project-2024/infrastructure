#!/bin/bash

set -e

# Function to update system packages
update_system() {
    echo "Updating system packages..."
    sudo apt-get update
}

# Function to install basic utilities
install_utilities() {
    echo "Installing Git, Vim, and Tree..."
    sudo apt-get install -y git vim tree unzip wget 
}

# Function to install AWS CLI v2
install_aws_cli() {
    echo "Installing AWS CLI v2..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
}

# Function to install Ansible
install_ansible() {
    echo "Installing Ansible..."
    sudo apt-add-repository ppa:ansible/ansible -y
    sudo apt-get update
    sudo apt-get install -y ansible
}

# Function to install Terraform
install_terraform() {
    echo "Installing Terraform..."
    wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip
    unzip terraform_1.0.0_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
}

# Function to install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce
}

# Function to set the time zone to New York
set_timezone_to_ny() {
    echo "Setting timezone to New York..."
    sudo timedatectl set-timezone America/New_York
}

main() {
    update_system
    install_utilities
    install_aws_cli
    install_ansible
    install_terraform
    install_kubectl
    install_docker
    set_timezone_to_ny
    echo "Installation complete."
}

main
