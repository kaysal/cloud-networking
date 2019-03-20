locals {
  vyosa_tunnel_gcp_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_gcp_tunnel_inside_address2}"
  vyosb_tunnel_gcp_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_gcp_tunnel_inside_address2}"
  vyosa_tunnel_aws_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_aws_tunnel_inside_address2}"
  vyosb_tunnel_aws_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_aws_tunnel_inside_address2}"
}

# VPN Connection Interface 1
#------------------------------
resource "google_compute_router_interface" "aws_eu_w1_vpc1_tunnel1" {
  name       = "${var.nva}aws-eu-w1-vpc1-tunnel1"
  router     = "${google_compute_router.eu_w1_cr_vpn.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.aws_eu_w1_vpc1_tunnel1.name}"
  ip_range   = "${local.vyosa_tunnel_gcp_vti}/30"
  region     = "europe-west1"
}

# VPN Connection Interface 2
#------------------------------
resource "google_compute_router_interface" "aws_eu_w1_vpc1_tunnel2" {
  name       = "${var.nva}aws-eu-w1-vpc1-tunnel2"
  router     = "${google_compute_router.eu_w1_cr_vpn.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.aws_eu_w1_vpc1_tunnel2.name}"
  ip_range   = "${local.vyosb_tunnel_gcp_vti}/30"
  region     = "europe-west1"
}

# BGP Session 1
#------------------------------
resource "google_compute_router_peer" "aws_eu_w1_vpc1_tunnel1" {
  name                      = "${var.nva}aws-eu-w1-vpc1-tunnel1"
  router                    = "${google_compute_router.eu_w1_cr_vpn.name}"
  peer_ip_address           = "${local.vyosa_tunnel_aws_vti}"
  peer_asn                  = 65010
  #advertised_route_priority = 251
  interface                 = "${google_compute_router_interface.aws_eu_w1_vpc1_tunnel1.name}"
  region = "europe-west1"
}

# BGP Session 2
#------------------------------
resource "google_compute_router_peer" "aws_eu_w1_vpc1_tunnel2" {
  name                      = "${var.nva}aws-eu-w1-vpc1-tunnel2"
  router                    = "${google_compute_router.eu_w1_cr_vpn.name}"
  peer_ip_address           = "${local.vyosb_tunnel_aws_vti}"
  peer_asn                  = 65010
  #advertised_route_priority = 251
  interface                 = "${google_compute_router_interface.aws_eu_w1_vpc1_tunnel2.name}"
  region = "europe-west1"
}
