terraform {
  required_version = ">= 0.12.8"
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  description   = "Allow SSH from anywhere"
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_project_metadata" "user_key" {
  metadata = {
    ssh-keys = <<EOF
appuser1:${file(var.public_key_path)} appuser2:${file(var.public_key_path)} appuser3:${file(var.public_key_path)}
EOF
  }
}
