# network
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.main}vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

# subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w1_10_200_20" {
  name                     = "${var.main}eu-w1-10-200-20"
  region                   = "europe-west1"
  network                  = google_compute_network.vpc.self_link
  ip_cidr_range            = "10.200.20.0/24"
  private_ip_google_access = false
  enable_flow_logs         = false
}

resource "google_compute_subnetwork" "gke_eu_w1_10_0_12" {
  name                     = "${var.main}gke-eu-w1-10-0-12"
  region                   = "europe-west1"
  network                  = google_compute_network.vpc.self_link
  ip_cidr_range            = "10.0.12.0/22"
  private_ip_google_access = false
  enable_flow_logs         = true

  secondary_ip_range {
    range_name    = "svc-range"
    ip_cidr_range = "10.0.96.0/20"
  }

  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = "10.12.0.0/14"
  }
}

resource "google_compute_subnetwork" "gke_eu_w2_10_0_16" {
  name                     = "${var.main}gke-eu-w2-10-0-16"
  region                   = "europe-west2"
  network                  = google_compute_network.vpc.self_link
  ip_cidr_range            = "10.0.16.0/22"
  private_ip_google_access = false
  enable_flow_logs         = true

  secondary_ip_range {
    range_name    = "svc-range"
    ip_cidr_range = "10.0.112.0/20"
  }

  secondary_ip_range {
    range_name    = "pod-range"
    ip_cidr_range = "10.16.0.0/14"
  }
}

# VPN GW external IP
#--------------------------------------
resource "google_compute_address" "eu_w1_vpn_gw_ip" {
  name   = "${var.main}eu-w1-vpn-gw-ip"
  region = "europe-west1"
}
