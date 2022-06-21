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
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Initialize Kubernetes master server

sudo kubeadm init
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy a pod network

curl https://docs.projectcalico.org/manifests/calico.yaml -O

kubectl apply -f calico.yaml

# Create node token

kubeadm token create --print-join-command
