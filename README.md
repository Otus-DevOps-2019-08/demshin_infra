# demshin_infra

demshin Infra repository

## Homework-9. Ansible-2

1. Creating Ansible Play for configure db & app hosts, deploy app.
2. Then creating multiple Plays.
3. Separate multiple play in different plays.
4. Use dynamic inventory.
5. Provisioning packer with ansible.

## Homework-8. Ansible-1

When you start the playbook in the first case, the directory with the code was already there, so there were no changes, and in the second it was deleted, and you saw that the change appeared. But the result is the same in both cases.

### Additional task. Dynamic inventory

Working with Dynamic inventory via GCP Inventory plugin.
1. Install `requests` and `google-auth` with command `pip3 install requests google-auth`.
2. See `inventory.gcp.yml`.
3. Get `key.json` with command `gcloud iam service-accounts keys create ~/key.json --iam-account [SA-NAME]@[PROJECT-ID].iam.gserviceaccount.com`.
4. To check run `ansible-inventory -i inventory.gcp.yml --graph` or `ansible -i inventory.gcp.yml all -m ping`.

## Homework-7. Terraform-2

- import firewall rules
- create packer images `app.json` & `db.json`
- separate `app.tf`, `db.tf` & `vpc.tf` from `main.tf`
- create modules app, db, vpc
- parameterization of vpc module with source_ranges
- create environments (prod & stage)
- create bucket with module

### Additional task. Remote backends

Created remote backends at prod & stage environments with `backend "gcs"`.

### Additional task. Provisioners in modules

- add provisioners
- add output variable for internal db IP address
- allow external connection to install_mongodb

## Homework 6. Terraform-1

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
