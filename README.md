# Terraform Azure Linux VM AutoDeploy

This project automates the deployment of a Linux Virtual Machine in Microsoft Azure using Terraform. It also uses a shell script (`basics.sh`) to install essential system and DevOps tools during provisioning.

## 📁 Project Structure


```bash
terraform-azure-linuxvm-autodeploy/
├── Executable-Files/
│   └── basics.sh           # Shell script to install packages on the VM
├── main.tf                 # Main Terraform configuration
├── outputs.tf              # Output values
├── provider.tf             # Azure provider settings
├── variables.tf            # Input variables
├── terraform.tfvars        # Values for variables
├── locals.tf               # Local values (e.g. private key content)
├── .gitignore              # Ignore .terraform and sensitive files
├── LICENSE                 # Project license (e.g., MIT)
└── README.md               # Project documentation (this file)

## 🧪 Installed Packages (`basics.sh`)

The VM will be provisioned with the following real-world tools and utilities:

```bash
#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

# Common tools
sudo apt install -y curl wget git unzip htop vim net-tools

# Networking
sudo apt install -y nmap tcpdump traceroute netcat iperf3

# System monitoring
sudo apt install -y sysstat iftop iotop glances

# DevOps tools
sudo apt install -y docker.io docker-compose ansible

# Security & SSH
sudo apt install -y openssh-server fail2ban ufw

# Programming languages
sudo apt install -y python3 python3-pip

# Utilities
sudo apt install -y screen tmux lsof

# Clean up
sudo apt autoremove -y
```

## 🚀 Deployment Steps

1. **Clone the repository**  
   ```bash
   git clone https://github.com/senani-derradji/terraform-azure-linuxvm-autodeploy.git
   cd terraform-azure-linuxvm-autodeploy
   ```

2. **Configure Azure CLI**
   ```bash
   az login
   az account set --subscription "<your-subscription-id>"
   ```

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

4. **Plan the deployment**
   ```bash
   terraform plan
   ```

5. **Apply the configuration**
   ```bash
   terraform apply -auto-approve
   ```

## 📦 Output

- VM public IP
- SSH access information

## 🛡️ Security Notes

- Private keys should not be committed to GitHub.
- Use `.gitignore` to exclude `.terraform/` and `.ssh/`
