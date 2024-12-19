#!/usr/bin/env bash
set -e

# Update and install prerequisites
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key and repository
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Optional: Add your user to the docker group to avoid using sudo for docker commands
sudo usermod -aG docker $USER
# You might need to re-login or run `newgrp docker` for the group change to take effect.

# Install Docker Compose plugin
sudo apt-get install -y docker-compose-plugin

# Test the installation
docker --version
docker compose version
