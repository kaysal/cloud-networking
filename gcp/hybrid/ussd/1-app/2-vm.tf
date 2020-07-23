
# locals

locals {
  web_init = templatefile("scripts/web.sh.tpl", {
  })
}

# ussd web server

resource "google_compute_instance" "ussd_vm" {
  name                      = "ussd-vm"
  machine_type              = "n1-standard-1"
  zone                      = "europe-west2-b"
  metadata_startup_script   = local.web_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = "debian-9"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.ussd_subnet.self_link
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
