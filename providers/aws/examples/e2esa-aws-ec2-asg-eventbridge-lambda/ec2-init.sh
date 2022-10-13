#!/bin/bash
sudo apt-get update -y 
sudo apt install apache2,zip -y
sudo systemctl status apache2

# Install AWS Cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install