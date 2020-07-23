
# network

resource "google_compute_network" "onprem" {
  name                    = "${var.global.prefix}onprem"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnet

resource "google_compute_subnetwork" "onprem_eu1" {
  name          = "${var.global.prefix}${var.onprem.prefix}onprem-eu1"
  ip_cidr_range = var.onprem.eu1.cidr
  region        = var.onprem.eu1.region
  network       = google_compute_network.onprem.self_link
}

resource "google_compute_subnetwork" "onprem_eu2" {
  name          = "${var.global.prefix}${var.onprem.prefix}onprem-eu2"
  ip_cidr_range = var.onprem.eu2.cidr
  region        = var.onprem.eu2.region
  network       = google_compute_network.onprem.self_link
}
