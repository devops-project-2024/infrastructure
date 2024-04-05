#!/bin/bash

# Update system package repository
echo "Updating system package repository..."
sudo apt-get update

# Install required packages
echo "Installing required packages..."
sudo apt-get install -y unzip curl

# Download AWS CLI v2
echo "Downloading AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the AWS CLI package
echo "Unzipping AWS CLI package..."
unzip awscliv2.zip

# Install AWS CLI v2
echo "Installing AWS CLI v2..."
sudo ./aws/install

# Verify the installation
echo "Verifying AWS CLI installation..."
aws --version

# Cleanup downloaded files
echo "Cleaning up..."
rm -rf awscliv2.zip aws

echo "AWS CLI installation completed successfully."
