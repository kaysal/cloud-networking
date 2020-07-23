
# locals

locals {
  vm_init = templatefile("scripts/vm.sh.tpl", {
  })
}

# vm - customer 1

resource "google_compute_instance" "spoke2" {
  name                      = "${var.global.prefix}spoke2"
  machine_type              = "n1-standard-1"
  zone                      = "${var.spoke2.location}-b"
  metadata_startup_script   = local.vm_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spoke2.self_link
    network_ip = var.spoke2.ip.vm
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.spoke2.email
  }
}
