#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# install packer
curl -SL https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip -o packer_1.5.1_linux_amd64.zip
unzip packer_1.5.1_linux_amd64.zip
sudo mv packer /usr/bin/packer

# validate packer templates
packer validate -var-file=packer/variables-reddit-full.json.example packer/app.json
packer validate -var-file=packer/variables-reddit-full.json.example packer/db.json
cd packer
packer validate -var-file=variables-reddit-full.json.example immutable.json
packer validate -var-file=variables-reddit-full.json.example ubuntu16.json
