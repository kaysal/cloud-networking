# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "global_vpc" {
  name                    = "${var.name}global-vpc"
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w1_subnet_10_100_10" {
  name          = "${var.name}eu-w1-subnet-10-100-10"
  region        = "europe-west1"
  network       = "${google_compute_network.global_vpc.self_link}"
  private_ip_google_access = true
  ip_cidr_range = "10.100.10.0/24"

  secondary_ip_range {
    range_name = "${var.name}eu-w1-alias-10-100-11"
    ip_cidr_range= "10.100.11.0/24"
  }
}

resource "google_compute_subnetwork" "eu_w2_subnet_10_100_20" {
  name          = "${var.name}eu-w2-subnet-10-100-20"
  ip_cidr_range = "10.100.20.0/24"
  network       = "${google_compute_network.global_vpc.self_link}"
  region        = "europe-west2"
}

resource "google_compute_subnetwork" "us_e1_subnet_10_120_10" {
  name          = "${var.name}us-e1-subnet-10-120-10"
  region        = "us-east1"
  network       = "${google_compute_network.global_vpc.self_link}"
  ip_cidr_range = "10.120.10.0/24"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "k8s_subnet_10_0_8" {
  name          = "${var.name}k8s-subnet-10-0-8"
  region        = "europe-west1"
  network       = "${google_compute_network.global_vpc.self_link}"
  ip_cidr_range = "10.0.8.0/22"
  private_ip_google_access = true

  secondary_ip_range {
    range_name = "svc-range"
    ip_cidr_range= "10.0.48.0/20"
  }

  secondary_ip_range {
    range_name = "pod-range"
    ip_cidr_range= "10.8.0.0/14"
  }
}

# Create VPN GW external IP addresses
#--------------------------------------
resource "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw1-ip"
  region = "europe-west1"
}

resource "google_compute_address" "gcp_eu_w1_vpn_gw2_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw2-ip"
  region = "europe-west1"
}

resource "google_compute_address" "gcp_us_e1_vpn_gw1_ip" {
  name = "${var.name}gcp-us-e1-vpn-gw1-ip"
  region = "us-east1"
}

resource "google_compute_address" "gcp_us_e1_vpn_gw2_ip" {
  name = "${var.name}gcp-us-e1-vpn-gw2-ip"
  region = "us-east1"
}
