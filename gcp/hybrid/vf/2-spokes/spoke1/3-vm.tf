
# locals

locals {
  vm_init = templatefile("scripts/vm.sh.tpl", {
  })
}

# vm - customer 1

resource "google_compute_instance" "spoke1" {
  name                      = "${var.global.prefix}spoke1"
  machine_type              = "n1-standard-1"
  zone                      = "${var.spoke1.location}-b"
  metadata_startup_script   = local.vm_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spoke1.self_link
    network_ip = var.spoke1.ip.vm
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.spoke1.email
  }
}
