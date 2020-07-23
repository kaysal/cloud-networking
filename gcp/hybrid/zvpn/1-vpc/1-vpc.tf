
# vpc

resource "google_compute_network" "vpc" {
  name                    = "${var.global.prefix}vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

# subnets

resource "google_compute_subnetwork" "ovpn" {
  provider      = google-beta
  name          = "${var.global.prefix}ovpn"
  ip_cidr_range = var.gcp.subnet.ovpn
  region        = var.gcp.region
  network       = google_compute_network.vpc.self_link
}

# ip addresses

resource "google_compute_address" "ovpn_ext_ip" {
  name   = "${var.global.prefix}ovpn-ext-ip"
  region = var.gcp.region
}

# cloud nat

resource "google_compute_router" "router" {
  name    = "${var.global.prefix}router"
  region  = var.gcp.region
  network = google_compute_network.vpc.self_link

  bgp {
    asn = var.gcp.asn
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.global.prefix}nat"
  router                             = google_compute_router.router.name
  region                             = var.gcp.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  min_ports_per_vm                   = "28672"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = "true"
    filter = "ERRORS_ONLY"
  }
}
