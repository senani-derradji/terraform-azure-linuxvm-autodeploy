#!/bin/bash

# Update system
sudo apt update -y && sudo apt upgrade -y

# Essentials for all environments
sudo apt install -y curl wget git unzip htop ufw net-tools gnupg software-properties-common ca-certificates lsb-release

# SSH server (if not already present)
sudo apt install -y openssh-server

# Monitoring and troubleshooting tools
sudo apt install -y sysstat iftop iotop dstat nmon bmon

# Security tools
sudo apt install -y fail2ban clamav gnupg2

# Docker (containerization)
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Python + Pip (Dev + Automation)
sudo apt install -y python3 python3-pip

# Terraform (Infrastructure as Code) — optional
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y && sudo apt install -y terraform

# Azure CLI (for managing Azure from VM)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Node.js & npm (optional - useful for some CLI or tooling)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# GitHub CLI (optional)
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
  sudo apt update -y && sudo apt install gh -y

# Clean
sudo apt autoremove -y
