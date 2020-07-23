
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

resource "google_compute_subnetwork" "gclb" {
  provider      = google-beta
  name          = "${var.global.prefix}gclb"
  ip_cidr_range = var.gcp.subnet.gclb
  region        = var.gcp.region
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "ilb" {
  provider      = google-beta
  name          = "${var.global.prefix}ilb"
  ip_cidr_range = var.gcp.subnet.ilb
  region        = var.gcp.region
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "tcp" {
  provider      = google-beta
  name          = "${var.global.prefix}tcp"
  ip_cidr_range = var.gcp.subnet.tcp
  region        = var.gcp.region
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "proxy" {
  provider      = google-beta
  name          = "${var.global.prefix}proxy"
  ip_cidr_range = var.gcp.subnet.proxy
  region        = var.gcp.region
  network       = google_compute_network.vpc.self_link
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
}

# ip addresses

resource "google_compute_address" "ovpn_ext_ip" {
  name   = "${var.global.prefix}ovpn-ext-ip"
  region = var.gcp.region
}

resource "google_compute_global_address" "gclb_vip" {
  name        = "${var.global.prefix}gclb-vip"
  description = "static ipv4 address for gclb frontend"
}

resource "google_compute_global_address" "tcp_vip" {
  name        = "${var.global.prefix}tcp-vip"
  description = "static ipv4 address for tcp frontend"
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
