#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# install ansible
sudo pip install --upgrade pip
sudo pip install ansible
sudo pip install ansible-lint

# Ansible Check
echo "=============================="
echo "Ansible Check"
echo "=============================="
ansible-lint -x 401 ${ROOT_DIR}/ansible/playbooks/*
