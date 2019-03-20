# host network
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

# service project subnets
#--------------------------------------
# apple service project
resource "google_compute_subnetwork" "apple_eu_w1_10_100_10" {
  name                     = "${var.name}apple-eu-w1-10-100-10"
  region                   = "europe-west1"
  network                  = "${google_compute_network.vpc.self_link}"
  ip_cidr_range            = "10.100.10.0/24"
  private_ip_google_access = true
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "apple_eu_w2_10_150_10" {
  name                     = "${var.name}apple-eu-w2-10-150-10"
  region                   = "europe-west2"
  network                  = "${google_compute_network.vpc.self_link}"
  ip_cidr_range            = "10.150.10.0/24"
  private_ip_google_access = true
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "apple_eu_w3_10_200_10" {
  name             = "${var.name}apple-eu-w3-10-200-10"
  ip_cidr_range    = "10.200.10.0/24"
  network          = "${google_compute_network.vpc.self_link}"
  region           = "europe-west3"
  enable_flow_logs = true

  secondary_ip_range {
    range_name    = "neg-range"
    ip_cidr_range = "10.0.80.0/22"
  }
}

resource "google_compute_subnetwork" "apple_us_e1_10_250_10" {
  name                     = "${var.name}apple-us-e1-10-250-10"
  ip_cidr_range            = "10.250.10.0/24"
  network                  = "${google_compute_network.vpc.self_link}"
  region                   = "us-east1"
  private_ip_google_access = true
  enable_flow_logs         = true
}

# Kubernetes service project #1
resource "google_compute_subnetwork" "gke_eu_w1_10_0_4" {
  name                     = "${var.name}gke-eu-w1-10-0-4"
  region                   = "europe-west1"
  network                  = "${google_compute_network.vpc.self_link}"
  ip_cidr_range            = "10.0.4.0/22"
  private_ip_google_access = true
  enable_flow_logs         = true

  secondary_ip_range {
    range_name    = "svc-range"
    ip_cidr_range = "10.0.32.0/20"
  }

  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = "10.4.0.0/14"
  }
}

# Kubernetes service project #2
resource "google_compute_subnetwork" "gke_eu_w2_10_0_8" {
  name                     = "${var.name}gke-eu-w2-10-0-8"
  region                   = "europe-west2"
  network                  = "${google_compute_network.vpc.self_link}"
  ip_cidr_range            = "10.0.8.0/22"
  private_ip_google_access = true
  enable_flow_logs         = true

  secondary_ip_range {
    range_name    = "svc-range"
    ip_cidr_range = "10.0.48.0/20"
  }

  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = "10.8.0.0/14"
  }
}

# External IPs
#--------------------------------------
# to aws
resource "google_compute_address" "vpn_gw_ip_eu_w1" {
  name   = "${var.name}vpn-gw-ip-eu-w1"
  region = "europe-west1"
}

resource "google_compute_address" "vpn_gw1_ip_us_e1" {
  name   = "${var.name}vpn-gw1-ip-us-e1"
  region = "us-east1"
}

resource "google_compute_address" "vpn_gw2_ip_us_e1" {
  name   = "${var.name}vpn-gw2-ip-us-e1"
  region = "us-east1"
}

# to Mango Project
resource "google_compute_address" "vpn_gw_ip_eu_w2" {
  name   = "${var.name}vpn-gw-ip-eu-w2"
  region = "europe-west2"
}

/*# to ???
resource "google_compute_address" "gcp_eu_w3_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w3-vpn-gw1-ip"
  region = "europe-west3"
}*/
