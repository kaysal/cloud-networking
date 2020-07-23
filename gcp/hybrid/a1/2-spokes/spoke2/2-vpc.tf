
# network

resource "google_compute_network" "spoke2_vpc" {
  name                    = "${var.global.prefix}${var.spoke2.prefix}vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnet

resource "google_compute_subnetwork" "spoke2_subnet" {
  name          = "${var.global.prefix}${var.spoke2.prefix}subnet"
  ip_cidr_range = var.spoke2.cidr
  region        = var.spoke2.region
  network       = google_compute_network.spoke2_vpc.self_link
}
