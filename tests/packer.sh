#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# validate packer templates
cd packer
packer validate -var-file=variables-reddit-full.json.example immutable.json
packer validate -var-file=variables-reddit-full.json.example ubuntu16.json
