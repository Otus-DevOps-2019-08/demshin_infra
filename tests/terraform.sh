#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# install terraform

curl https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip -o /tmp/terraform.zip
sudo unzip /tmp/terraform.zip -d /usr/bin

# Install tflint
curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip

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
