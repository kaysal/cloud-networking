# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w1_subnet_10_10_10" {
  name          = "${var.name}eu-w1-subnet-10-10-10"
  ip_cidr_range = "10.10.10.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "eu_w2_subnet_10_10_20" {
  name          = "${var.name}eu-w2-subnet-10-10-20"
  ip_cidr_range = "10.10.20.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west2"
}

resource "google_compute_subnetwork" "us_e1_subnet_10_50_10" {
  name          = "${var.name}us-e1-subnet-10-50-10"
  ip_cidr_range = "10.50.10.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "us-east1"
}

# Create VPN GW external IP addresses
#--------------------------------------
resource "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "gcp-eu-w1-vpn-gw1-ip"
  region = "europe-west1"
}

resource "google_compute_address" "gcp_eu_w1_vpn_gw2_ip" {
  name = "gcp-eu-w1-vpn-gw2-ip"
  region = "europe-west1"
}

resource "google_compute_address" "gcp_us_e1_vpn_gw1_ip" {
  name = "gcp-us-e1-vpn-gw1-ip"
  region = "us-east1"
}

resource "google_compute_address" "gcp_us_e1_vpn_gw2_ip" {
  name = "gcp-us-e1-vpn-gw2-ip"
  region = "us-east1"
}
