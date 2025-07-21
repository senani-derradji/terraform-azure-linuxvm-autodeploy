#!bin/bash

echo "Starting ...."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install apache2 -y
sudo apt-get install nmap -y

echo "Anything ...."