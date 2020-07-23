
# vpc

resource "google_compute_network" "spoke2" {
  name                    = "${var.global.prefix}spoke2"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnets

resource "google_compute_subnetwork" "spoke2" {
  name          = "${var.global.prefix}spoke2"
  ip_cidr_range = var.spoke2.cidr
  region        = var.spoke2.location
  network       = google_compute_network.spoke2.self_link
}
