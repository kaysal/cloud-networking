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
  private_ip_google_access = true
  enable_flow_logs         = true
}

# VPN GW external IP
#--------------------------------------
resource "google_compute_address" "eu_w1_vpn_gw_ip" {
  name   = "${var.main}eu-w1-vpn-gw-ip"
  region = "europe-west1"
}

