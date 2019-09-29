# demshin_infra

demshin Infra repository

## Homework 6. Terraform-194

- terraform installing
- using terraform provider google
- creating resources (instance, firewall) with terraform
- working with terraform state
- using metadata for ssh keys
- using outputs
- using provisioners (file & remote exec)
- using input variables

### Additional task. Working with metadata

Add ssh keys to project metadata with `resource "google_compute_project_metadata"`.
When we adding key at the GCP web console and run `terraform apply` after that, the added key is overwritten.

### Additional task. Load balancer

See `lb.tf` and some edits at `main.tf` (name, count) and new output variable `lb_external_ip`.

## Homework 5. Packer

Build simple image with packer.

```bash
packer validate ubuntu16.json
packer build ubuntu16.json
```

### Parameterization of the template

Parameterization of the template with user variables. See `"variables"` section at file `ubuntu16.json` and file `variables.json`. Create `variables.json` from `variables.json.example`. To run:

```bash
packer validate -var-file=variables.json ubuntu16.json
packer build -var-file=variables.json ubuntu16.json
```

### Additional task. Immutable infrastructure

Creating template `immutable.json` with user variables `variables-reddit-full.json` (see `variables-reddit-full.json.example`), additional files at `files` directory.

### Additional task. Script for create & start reddit vm

To run:

```bash
sh create-reddit-vm.sh
```

## Homework 4. Cloud app

testapp_IP = 35.228.78.194
testapp_port = 9292

## Scripts

Scripts `install_mongodb.sh`, `install_ruby.sh` & `deploy.sh` created.

### Additional task. Startup script as local file

Script `deploy.sh` created.

```bash
gcloud compute instances create reddit-app-2\
  --zone=europe-north1-a \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=./startup.sh
```

### Additional task. Startup script as remote url

```bash
gcloud compute instances create reddit-app-2\
  --zone=europe-north1-a \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata startup-script-url=https://raw.githubusercontent.com/otus-DevOps-2019-08/demshin_infra/startup.sh
```

### Additional task. Create firewall rule for puma app (port 9292) with gcloud command

```bash
gcloud compute firewall-rules create default-puma-server\
  --allow=tcp:9292 \
  --target-tags=puma-server
```

## Homework 3. Bastion & vpn

### Bastion

bastion_IP = 35.228.78.194
someinternalhost_IP = 10.166.0.3

Connect to `someinternalhost` with `ProxyJump` option.

```bash
ssh -i ~/.ssh/appuser -A -J appuser@35.228.78.194 appuser@10.166.0.3
```

### Additional task Bastion

This solution uses `ProxyJump` option too. First you need to add some configuration to ssh config:

```bash
 echo "Host someinternalhost
    HostName 10.166.0.3
    User appuser
    ProxyJump appuser@35.228.78.194" >> ~/.ssh/config
```

Then run:

```bash
ssh someinternalhost
```

PROFIT!

## VPN Server

Pritunl works.

### Additional task Pritunl

Pritunl works with correct ssl certs with sslip.io & Let's Encrypt services'.
