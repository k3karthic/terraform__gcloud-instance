/*
 * Variables
 */

variable "name" {}
variable "zone" {}
variable "subnetwork" {}

variable "image_os" {}
variable "image_id" {}

variable "ydns_host" {}

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
  name         = var.name
  zone         = var.zone
  machine_type = "f1-micro"

  tags = [
    "public"
  ]

  boot_disk {
    initialize_params {
      size  = 30
      image = var.image_id
    }
  }

  network_interface {
    subnetwork = var.subnetwork

    // Ephemeral Public IP
    access_config {}
  }

  service_account {
    email  = google_service_account.free.email
    scopes = ["cloud-platform"]
  }

  labels = {
    "os"          = var.image_os
    "ydns_host"   = "yes"
    "tor_service" = "yes"
  }

  metadata = {
    "ydns_host" = var.ydns_host
    "ssh-keys"  = "freebsd:${file("ssh/google.pub")}"
  }
}
