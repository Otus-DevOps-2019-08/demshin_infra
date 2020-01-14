#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# install ansible
pip install --upgrade pip
pip install ansible
pip install ansible-lint
