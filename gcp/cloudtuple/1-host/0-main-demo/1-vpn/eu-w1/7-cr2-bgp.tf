# VPN Connection Interface
#------------------------------
resource "google_compute_router_interface" "aws_eu_w1_vpc1_tunnel2" {
  name       = "${var.name}aws-eu-w1-vpc1-tunnel2"
  router     = "${google_compute_router.eu_w1_cr2.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.aws_eu_w1_vpc1_tunnel2.name}"
  ip_range   = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_gcp_tunnel_inside_address}"
  region     = "europe-west1"
}

# BGP Session
#------------------------------
resource "google_compute_router_peer" "aws_eu_w1_vpc1_tunnel2" {
  name                      = "${var.name}aws-eu-w1-vpc1-tunnel2"
  router                    = "${google_compute_router.eu_w1_cr2.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_aws_tunnel_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 251
  interface                 = "${google_compute_router_interface.aws_eu_w1_vpc1_tunnel2.name}"
  region = "europe-west1"
}
