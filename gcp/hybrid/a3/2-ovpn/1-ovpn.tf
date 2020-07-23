
# vpn server

locals {
  ovpn_init = templatefile("scripts/ovpn.sh.tpl", {
    KEY_COUNTRY   = "UK"
    KEY_PROVINCE  = "London"
    KEY_CITY      = "London"
    KEY_ORG       = "Cloudtuple"
    KEY_EMAIL     = "admin@cloudtuple.com"
    KEY_NAME      = "server"
    SERVER_EXT_IP = local.ip.ovpn_ext_ip.address
    SERVER_NAME   = "${var.global.prefix}ovpn"
    SERVER_LAN1   = "10.1.0.0 255.255.255.0"
    SERVER_LAN2   = "10.2.0.0 255.255.255.0"
    SERVER_LAN3   = "10.3.0.0 255.255.255.0"
    CLIENT1       = "linux"
    CLIENT2       = "windows"
    CLIENT_RANGE  = var.gcp.subnet.client
  })
}

data "google_compute_image" "ubuntu" {
  provider = google-beta
  project  = "ubuntu-os-cloud"
  family   = "ubuntu-1604-lts"
}

resource "google_compute_instance" "ovpn" {
  name                      = "${var.global.prefix}ovpn"
  machine_type              = var.gcp.machine_type.ovpn
  zone                      = "${var.gcp.region}-b"
  metadata_startup_script   = local.ovpn_init
  allow_stopping_for_update = "true"
  can_ip_forward            = "true"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }

  network_interface {
    subnetwork = local.subnet.ovpn.self_link
    access_config {
      nat_ip = local.ip.ovpn_ext_ip.address
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
