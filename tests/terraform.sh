#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# terraform validate

cd "${ROOT_DIR}"/terraform
terraform validate
cd "${ROOT_DIR}"/terraform/prod
terraform validate
cd "${ROOT_DIR}"/terraform/stage
terraform validate

# tflint

cd "${ROOT_DIR}"/terraform
