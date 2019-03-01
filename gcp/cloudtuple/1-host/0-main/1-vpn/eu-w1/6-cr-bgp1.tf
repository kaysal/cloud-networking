# VPN Connection Interface
#------------------------------
resource "google_compute_router_interface" "aws_eu_w1_vpc1_tunnel1" {
  name       = "${var.name}aws-eu-w1-vpc1-tunnel1"
  router     = "${google_compute_router.eu_w1_cr_vpn_vpc.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.aws_eu_w1_vpc1_tunnel1.name}"
  ip_range   = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_gcp_tunnel_inside_address}"
  region     = "europe-west1"
}

# BGP Session
#------------------------------
resource "google_compute_router_peer" "aws_eu_w1_vpc1_tunnel1" {
  name                      = "${var.name}aws-eu-w1-vpc1-tunnel1"
  router                    = "${google_compute_router.eu_w1_cr_vpn_vpc.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_aws_tunnel_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 251
  interface                 = "${google_compute_router_interface.aws_eu_w1_vpc1_tunnel1.name}"
  region = "europe-west1"
}
