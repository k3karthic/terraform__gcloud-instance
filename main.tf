/*
 * Variables
 */

variable "project" {}
variable "name" {}
variable "zone" {}
variable "subnetwork" {}

variable "image_os" {}
variable "image_id" {}

variable "njalla_domain" {}
variable "njalla_domain_id" {}

/*
 * Providers
 */

provider "google" {}

/*
 * Configuration
 */

//
// Service Account
//

resource "google_service_account" "free" {
  account_id = "mg-gcloud--instance"
}

//
// Instance
//

resource "google_compute_instance" "free" {
  project = var.project
  name = var.name
  zone = var.zone

  machine_type   = "e2-micro"
  desired_status = "RUNNING"

  tags = [
    "public",
    "shadowsocks"
  ]

  boot_disk {
    initialize_params {
      size  = 30
      image = var.image_id
    }
  }

  network_interface {
    subnetwork = var.subnetwork
	subnetwork_project = var.project

    // Ephemeral Public IP
    access_config {}
  }

  service_account {
    email  = google_service_account.free.email
    scopes = ["cloud-platform"]
  }

  labels = {
    "os"                  = var.image_os
    "njalla_host"         = "yes"
    "tor_service"         = "yes"
    "shadowsocks_service" = "yes"
  }

  metadata = {
    "njalla_domain"    = var.njalla_domain
    "njalla_domain_id" = var.njalla_domain_id
    "ssh-keys"         = "freebsd:${file("ssh/google.pub")}"
  }
}
