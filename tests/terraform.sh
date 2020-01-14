#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# install terraform

curl https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip -o /tmp/terraform.zip
sudo unzip /tmp/terraform.zip -d /usr/bin

# Install tflint
curl https://raw.githubusercontent.com/wata727/tflint/master/install_linux.sh | bash

# tflint & terraform validate
echo "================================"
echo "Terraform Validate"
echo "================================"
cd "${ROOT_DIR}"/terraform
tflint && terraform get && terraform init -backend=false && terraform validate
cd "${ROOT_DIR}"/terraform/prod
tflint && terraform get && terraform init -backend=false && terraform validate
cd "${ROOT_DIR}"/terraform/stage
tflint && terraform get && terraform init -backend=false && terraform validate

cd "${ROOT_DIR}"/terraform
