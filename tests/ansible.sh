#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# install ansible
sudo pip install --upgrade pip
sudo pip install ansible
sudo pip install ansible-lint
