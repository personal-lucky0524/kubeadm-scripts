#! /bin/bash

sudo apt-get update -y
# Docker Installation

sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu

sudo systemctl start docker
sudo systemctl enable docker

# Kubernetes Installation

sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get install -y kubeadm kubelet kubectl kubernetes-cni

# Disable swap memory

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
