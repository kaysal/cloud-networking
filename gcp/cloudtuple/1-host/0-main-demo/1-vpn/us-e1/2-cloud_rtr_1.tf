# Cloud routers
resource "google_compute_router" "us_e1_cr1" {
  name    = "${var.name}us-e1-cr1"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "us-east1"

  bgp {
    asn = 65000
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # private dns range
    advertised_ip_ranges {
      range = "35.199.192.0/19"
    }

    # restricted google api range
    advertised_ip_ranges {
      range = "199.36.153.4/30"
    }
  }
}

# gcp eu-w2-vpn-gw1
resource "google_compute_router_interface" "aws_eu_w2_vpc1_cgw3_tunnel1" {
  name       = "${var.name}aws-eu-w2-vpc1-cgw3-tunnel1"
  router     = "${google_compute_router.us_e1_cr1.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_aws_eu_w2_vpc1_cgw3_tunnel1.name}"
  ip_range = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.gcp_eu_w2_vpc1_cgw3_tunnel1_cgw_inside_address}/30"
  region = "us-east1"
}

resource "google_compute_router_interface" "aws_eu_w2_vpc1_cgw3_tunnel2" {
  name       = "${var.name}aws-eu-w2-vpc1-cgw3-tunnel2"
  router     = "${google_compute_router.us_e1_cr1.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_aws_eu_w2_vpc1_cgw3_tunnel2.name}"
  ip_range = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.gcp_eu_w2_vpc1_cgw3_tunnel2_cgw_inside_address}/30"
  region = "us-east1"
}

resource "google_compute_router_peer" "aws_eu_w2_vpc1_cgw3_tunnel1" {
  name                      = "${var.name}aws-eu-w2-vpc1-cgw3-tunnel1"
  router                    = "${google_compute_router.us_e1_cr1.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.aws_eu_w2_vpc1_cgw3_tunnel1_vgw_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 201
  interface                 = "${google_compute_router_interface.aws_eu_w2_vpc1_cgw3_tunnel1.name}"
  region = "us-east1"
}

resource "google_compute_router_peer" "aws_eu_w2_vpc1_cgw3_tunnel2" {
  name                      = "${var.name}aws-eu-w2-vpc1-cgw3-tunnel2"
  router                    = "${google_compute_router.us_e1_cr1.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.aws_eu_w2_vpc1_cgw3_tunnel2_vgw_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 251
  interface                 = "${google_compute_router_interface.aws_eu_w2_vpc1_cgw3_tunnel2.name}"
  region = "us-east1"
}