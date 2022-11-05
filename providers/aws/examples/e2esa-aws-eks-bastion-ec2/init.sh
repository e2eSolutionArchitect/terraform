#!/bin/bash

# Installing AWSCli
sudo apt install zip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Installing or updating kubectl
# https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

# Determine whether you already have kubectl installed on your device.
#kubectl version | grep Client | cut -d : -f 5


#To install or update kubectl on Linux

curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl

# (Optional) Verify the downloaded binary with the SHA-256 sum for your binary.
curl -o kubectl.sha256 https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl.sha256

# Apply execute permissions to the binary.
chmod +x ./kubectl

# Copy the binary to a folder in your PATH.
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# (Optional) Add the $HOME/bin path to your shell initialization file so that it is configured when you open a shell.
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

# After you install kubectl, you can verify its version with the following command:
kubectl version --short --client


# Installing or updating eksctl
# https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html

# Determine whether you already have eksctl installed on your device.
# eksctl version

# To install or update eksctl on Linux

# Download and extract the latest release of eksctl with the following command.
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Move the extracted binary to /usr/local/bin.
sudo mv /tmp/eksctl /usr/local/bin

# Test that your installation was successful with the following command.
eksctl version


# Configuring kubeconfig
aws eks --region us-east-1 update-kubeconfig --name e2esa-tutorials-eks-cluster
kubectl get nodes -o wide

# Downloading the manifest file
wget https://s3.us-west-2.amazonaws.com/amazon-eks/docs/eks-console-full-access.yaml

# Deploy the manifest file
kubectl apply -f eks-console-full-access.yaml
