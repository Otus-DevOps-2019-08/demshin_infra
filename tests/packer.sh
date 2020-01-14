#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

ROOT_DIR="$(pwd)"

# validate packer templates
cd "${ROOT_DIR}"/packer
packer validate -var-file=variables-reddit-full.json.example immutable.json
packer validate -var-file=variables-reddit-full.json.example ubuntu16.json
cd "${ROOT_DIR}"
