# host network
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
}

# service project subnets
#--------------------------------------
# apple service project
resource "google_compute_subnetwork" "apple_eu_w1_10_100_10" {
  name          = "${var.name}apple-eu-w1-10-100-10"
  region        = "europe-west1"
  network       = "${google_compute_network.vpc.self_link}"
  ip_cidr_range = "10.100.10.0/24"
  private_ip_google_access = true
  enable_flow_logs = true
}

resource "google_compute_subnetwork" "apple_eu_w2_10_150_10" {
  name          = "${var.name}apple-eu-w2-10-150-10"
  region        = "europe-west2"
  network       = "${google_compute_network.vpc.self_link}"
  ip_cidr_range = "10.150.10.0/24"
  private_ip_google_access = true
  enable_flow_logs = true
}

resource "google_compute_subnetwork" "apple_eu_w3_10_250_10" {
  name          = "${var.name}apple-eu-w3-10-250-10"
  ip_cidr_range = "10.250.10.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west3"
  enable_flow_logs = true
}

# Kubernetes service project #1
resource "google_compute_subnetwork" "gke_eu_w1_10_0_4" {
  name          = "${var.name}gke-eu-w1-10-0-4"
  region        = "europe-west1"
  network       = "${google_compute_network.vpc.self_link}"
  ip_cidr_range = "10.0.4.0/22"
  private_ip_google_access = true
  enable_flow_logs = true

  secondary_ip_range {
    range_name = "svc-range"
    ip_cidr_range= "10.0.32.0/20"
  }

  secondary_ip_range {
    range_name = "pod-range"
    ip_cidr_range= "10.4.0.0/14"
  }
}

# Kubernetes service project #2
resource "google_compute_subnetwork" "gke_eu_w2_10_0_8" {
  name          = "${var.name}gke-eu-w2-10-0-8"
  region        = "europe-west2"
  network       = "${google_compute_network.vpc.self_link}"
  ip_cidr_range = "10.0.8.0/22"
  private_ip_google_access = true
  enable_flow_logs = true

  secondary_ip_range {
    range_name = "svc-range"
    ip_cidr_range= "10.0.48.0/20"
  }

  secondary_ip_range {
    range_name = "pod-range"
    ip_cidr_range= "10.8.0.0/14"
  }
}

# VPN GW external IPs
#--------------------------------------
resource "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw1-ip"
  region = "europe-west1"
}

resource "google_compute_address" "gcp_eu_w1_vpn_gw2_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw2-ip"
  region = "europe-west1"
}

resource "google_compute_address" "gcp_eu_w2_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w2-vpn-gw1-ip"
  region = "europe-west2"
}

resource "google_compute_address" "gcp_eu_w2_vpn_gw2_ip" {
  name = "${var.name}gcp-eu-w2-vpn-gw2-ip"
  region = "europe-west2"
}

# to landing zone 2
resource "google_compute_address" "gcp_eu_w2_vpn_gw3_ip" {
  name = "${var.name}gcp-eu-w2-vpn-gw3-ip"
  region = "europe-west2"
}

resource "google_compute_address" "gcp_eu_w3_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w3-vpn-gw1-ip"
  region = "europe-west3"
}

# capture local machine ipv4 to use in security configuration
#--------------------------------------
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
