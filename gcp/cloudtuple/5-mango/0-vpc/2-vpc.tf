# network
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.main}vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

# subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w2_10_200_30" {
  name                     = "${var.main}eu-w2-10-200-30"
  region                   = "europe-west2"
  network                  = "${google_compute_network.vpc.self_link}"
  ip_cidr_range            = "10.200.30.0/24"
  private_ip_google_access = true
}

# VPN GW external IP
#--------------------------------------
resource "google_compute_address" "vpn_gw_ip_eu_w2" {
  name   = "${var.main}vpn-gw-ip-eu-w2"
  region = "europe-west2"
}

resource "google_compute_address" "policy_based_vpn_gw_ip" {
  name   = "policy-based-vpn-gw-ip"
  region = "us-east1"
}
