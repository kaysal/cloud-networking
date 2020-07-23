# Create networks
#--------------------------------------
// Adding VPC Networks to Project  MANAGEMENT
resource "google_compute_network" "mgt" {
  name                    = "${var.nva}mgt"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "untrust" {
  name                    = "${var.nva}untrust"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "trust" {
  name                    = "${var.nva}trust"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "mgt" {
  name             = "${var.nva}mgt"
  ip_cidr_range    = "10.0.0.0/24"
  network          = google_compute_network.mgt.self_link
  region           = "europe-west1"
  enable_flow_logs = true
}

resource "google_compute_subnetwork" "untrust" {
  name             = "${var.nva}untrust"
  ip_cidr_range    = "10.0.1.0/24"
  network          = google_compute_network.untrust.self_link
  region           = "europe-west1"
  enable_flow_logs = true
}

resource "google_compute_subnetwork" "trust" {
  name             = "${var.nva}trust"
  ip_cidr_range    = "10.0.2.0/24"
  network          = google_compute_network.trust.self_link
  region           = "europe-west1"
  enable_flow_logs = true
}

# VPN GW external IPs
#--------------------------------------
resource "google_compute_address" "vpn_gw_ip_eu_w1_" {
  name   = "${var.nva}vpn-gw-ip-eu-w1"
  region = "europe-west1"
}

