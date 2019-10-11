terraform {
  required_version = ">= 0.12.8"
}

provider "google" {
  project = var.project
  region  = var.region
}

module app {
  source          = "./modules/app"
  public_key_path = var.public_key_path
  zone            = var.zone
  app_disk_image  = var.app_disk_image
}

module db {
  source          = "./modules/db"
  public_key_path = var.public_key_path
  zone            = var.zone
  db_disk_image   = var.db_disk_image
}

module vpc {
  source = "./modules/vpc"
}

resource "google_compute_project_metadata" "user_key" {
  metadata = {
    ssh-keys = <<EOF
appuser1:${file(var.public_key_path)} appuser2:${file(var.public_key_path)} appuser3:${file(var.public_key_path)}
EOF
  }
}
