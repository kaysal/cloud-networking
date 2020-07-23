
# instance template

data "google_compute_image" "debian" {
  provider = google-beta
  project  = "debian-cloud"
  family   = "debian-9"
}

locals {
  template_init = templatefile("scripts/ilb.sh.tpl", {
  })
}

resource "google_compute_instance_template" "template" {
  provider     = google-beta
  name         = "${var.global.prefix}${local.prefix}template"
  machine_type = var.gcp.machine_type.normal
  tags         = ["gfe"]

  disk {
    source_image = data.google_compute_image.debian.self_link
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = local.subnet.ilb.self_link
  }

  metadata_startup_script = local.template_init

  service_account {
    scopes = ["cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = all
  }
}
