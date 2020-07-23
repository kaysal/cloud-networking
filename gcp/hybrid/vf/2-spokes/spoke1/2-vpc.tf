
# vpc

resource "google_compute_network" "spoke1" {
  name                    = "${var.global.prefix}spoke1"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnets

resource "google_compute_subnetwork" "spoke1" {
  name          = "${var.global.prefix}spoke1"
  ip_cidr_range = var.spoke1.cidr
  region        = var.spoke1.location
  network       = google_compute_network.spoke1.self_link
}
