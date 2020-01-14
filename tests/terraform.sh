#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# install terraform

# wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
# unzip terraform_0.12.19_linux_amd64.zip
# sudo mv terraform /usr/local/bin/

# terraform validate

cd "${ROOT_DIR}"/terraform
/usr/local/bin/terraform validate
cd "${ROOT_DIR}"/terraform/prod
/usr/local/bin/terraform validate
cd "${ROOT_DIR}"/terraform/stage
/usr/local/bin/terraform validate

# tflint

cd "${ROOT_DIR}"/terraform
