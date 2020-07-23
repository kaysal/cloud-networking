
# network

resource "google_compute_network" "spoke1_vpc" {
  name                    = "${var.global.prefix}${var.spoke1.prefix}vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnet

resource "google_compute_subnetwork" "spoke1_subnet" {
  name          = "${var.global.prefix}${var.spoke1.prefix}subnet"
  ip_cidr_range = var.spoke1.cidr
  region        = var.spoke1.region
  network       = google_compute_network.spoke1_vpc.self_link
}
