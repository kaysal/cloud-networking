
# locals

locals {
  web_init = templatefile("scripts/web.sh.tpl", {
    PREFIX            = var.global.prefix
    SPOKE1_8080       = var.hub.trust1.ip.web80
    SPOKE1_8081       = var.hub.trust1.ip.web81
    SPOKE2_8080       = var.hub.trust2.ip.web80
    SPOKE2_8081       = var.hub.trust2.ip.web81
    SPOKE1_PROJECT_ID = var.project_id_spoke1
    SPOKE2_PROJECT_ID = var.project_id_spoke2
  })
}

# web server 8080

resource "google_compute_instance" "web_80" {
  name                      = "${local.prefix_spoke2}web-80"
  machine_type              = "n1-standard-1"
  zone                      = "${var.hub.trust2.region}-b"
  metadata_startup_script   = local.web_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = local.subnet.self_link
    network_ip = var.hub.trust2.ip.web80
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = local.sa.spoke2.email
  }
}

# web server 8081

resource "google_compute_instance" "web_81" {
  name                      = "${local.prefix_spoke2}web-81"
  machine_type              = "n1-standard-1"
  zone                      = "${var.hub.trust2.region}-b"
  metadata_startup_script   = local.web_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = local.subnet.self_link
    network_ip = var.hub.trust2.ip.web81
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = local.sa.spoke2.email
  }
}
