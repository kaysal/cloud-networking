# gcp us-e1-vpn-gw1
resource "google_compute_router_interface" "aws_us_e1_vpc1_cgw1_tunnel1" {
  name       = "${var.name}aws-us-e1-vpc1-cgw1-tunnel1"
  router     = "${google_compute_router.us_e1_cr_vpn_vpc.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_aws_us_e1_vpc1_cgw1_tunnel1.name}"
  ip_range = "${data.terraform_remote_state.aws_us_e1_vpc1.gcp_cgw1_tunnel1_cgw_inside_address}/30"
  region = "us-east1"
}

resource "google_compute_router_interface" "aws_us_e1_vpc1_cgw1_tunnel2" {
  name       = "${var.name}aws-us-e1-vpc1-cgw1-tunnel2"
  router     = "${google_compute_router.us_e1_cr_vpn_vpc.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_aws_us_e1_vpc1_cgw1_tunnel2.name}"
  ip_range = "${data.terraform_remote_state.aws_us_e1_vpc1.gcp_cgw1_tunnel2_cgw_inside_address}/30"
  region = "us-east1"
}

resource "google_compute_router_peer" "aws_us_e1_vpc1_cgw1_tunnel1" {
  name                      = "${var.name}aws-us-e1-vpc1-cgw1-tunnel1"
  router                    = "${google_compute_router.us_e1_cr_vpn_vpc.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_us_e1_vpc1.aws_cgw1_tunnel1_vgw_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 201
  interface                 = "${google_compute_router_interface.aws_us_e1_vpc1_cgw1_tunnel1.name}"
  region = "us-east1"
}

resource "google_compute_router_peer" "aws_us_e1_vpc1_cgw1_tunnel2" {
  name                      = "${var.name}aws-us-e1-vpc1-cgw1-tunnel2"
  router                    = "${google_compute_router.us_e1_cr_vpn_vpc.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_us_e1_vpc1.aws_cgw1_tunnel2_vgw_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 251
  interface                 = "${google_compute_router_interface.aws_us_e1_vpc1_cgw1_tunnel2.name}"
  region = "us-east1"
}
