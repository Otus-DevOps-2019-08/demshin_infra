#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# terraform validate

cd terraform
terraform validate
cd prod
terraform validate
cd ../stage
terraform validate
