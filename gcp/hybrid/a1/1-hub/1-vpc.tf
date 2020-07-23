
# networks
#---------------------------------------

# untrust

resource "google_compute_network" "untrust" {
  name                    = "${var.global.prefix}untrust"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# trust

resource "google_compute_network" "trust1" {
  name                    = "${var.global.prefix}trust1"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_network" "trust2" {
  name                    = "${var.global.prefix}trust2"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnets
#---------------------------------------

# untrust

resource "google_compute_subnetwork" "untrust1" {
  name          = "${var.global.prefix}${var.hub.prefix}untrust1"
  ip_cidr_range = var.hub.untrust.eu1.cidr
  region        = var.hub.untrust.eu1.region
  network       = google_compute_network.untrust.self_link
}

resource "google_compute_subnetwork" "untrust2" {
  name          = "${var.global.prefix}${var.hub.prefix}untrust2"
  ip_cidr_range = var.hub.untrust.eu2.cidr
  region        = var.hub.untrust.eu2.region
  network       = google_compute_network.untrust.self_link
}

# trust eu1

resource "google_compute_subnetwork" "trust1" {
  name          = "${var.global.prefix}${var.hub.prefix}trust1"
  ip_cidr_range = var.hub.trust.eu1.cidr
  region        = var.hub.trust.eu1.region
  network       = google_compute_network.trust1.self_link
}

# trust eu2

resource "google_compute_subnetwork" "trust2" {
  name          = "${var.global.prefix}${var.hub.prefix}trust2"
  ip_cidr_range = var.hub.trust.eu2.cidr
  region        = var.hub.trust.eu2.region
  network       = google_compute_network.trust2.self_link
}
