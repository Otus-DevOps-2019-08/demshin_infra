# demshin_infra

demshin Infra repository

## Homework 5 Packer

Build simple image with packer.
```bash
packer build ubuntu16.json
```

## Homework 4

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

## Homework 3

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
