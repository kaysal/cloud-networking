
# locals

locals {
  web_init = templatefile("scripts/web.sh.tpl", {
    PREFIX     = var.global.prefix
    SPOKE_8080 = var.spoke2.ip.web80
    SPOKE_8081 = var.spoke2.ip.web81

    SPOKE1_PROJECT_ID = var.project_id_spoke1
    SPOKE2_PROJECT_ID = var.project_id_spoke2
  })
}

# web server 8080

resource "google_compute_instance" "web_80" {
  name                      = "${var.global.prefix}${var.spoke2.prefix}web-80"
  machine_type              = "n1-standard-1"
  zone                      = "${var.spoke2.region}-b"
  metadata_startup_script   = local.web_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = local.subnet.self_link
    network_ip = var.spoke2.ip.web80
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = local.sa.spoke2.email
  }
}

# web server 8081

resource "google_compute_instance" "web_81" {
  name                      = "${var.global.prefix}${var.spoke2.prefix}web-81"
  machine_type              = "n1-standard-1"
  zone                      = "${var.spoke2.region}-b"
  metadata_startup_script   = local.web_init
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = var.global.image
    }
  }

  network_interface {
    subnetwork = local.subnet.self_link
    network_ip = var.spoke2.ip.web81
    access_config {}
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = local.sa.spoke2.email
  }
}
