#!/usr/bin/env bash
set -e  # Exit on any error

# Ensure prerequisites are updated and installed
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg

# Check if lsb-release is installed; install if missing
if ! command -v lsb_release &> /dev/null; then
    sudo apt-get install -y lsb-release
fi

# Add Docker’s official GPG key and repository
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Optional: Add the current user to the docker group
sudo usermod -aG docker $USER

# Install Docker Compose plugin
sudo apt-get install -y docker-compose-plugin

# Test the installation
docker --version
docker compose version

echo "Docker and Docker Compose have been successfully installed."
