#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# validate packer templates
packer validate -var-file=packer/variables-reddit-full.json.example packer/app.json
packer validate -var-file=packer/variables-reddit-full.json.example packer/db.json
cd packer
packer validate -var-file=variables-reddit-full.json.example immutable.json
packer validate -var-file=variables-reddit-full.json.example ubuntu16.json
