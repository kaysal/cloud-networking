# network
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
}

# subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w2_10_200_30" {
  name          = "${var.name}eu-w2-10-200-30"
  region        = "europe-west2"
  network       = "${google_compute_network.vpc.self_link}"
  ip_cidr_range = "10.200.30.0/24"
  private_ip_google_access = true
}

# VPN GW external IP
#--------------------------------------
resource "google_compute_address" "eu_w2_vpn_gw_ip" {
  name = "${var.name}eu-w2-vpn-gw-ip"
  region = "europe-west2"
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
