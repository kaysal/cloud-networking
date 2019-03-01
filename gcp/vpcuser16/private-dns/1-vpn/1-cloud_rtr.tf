# Cloud router
resource "google_compute_router" "cloud_router" {
  name    = "${var.name}cloud-router"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "europe-west2"

  bgp {
    asn = 65020
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
resource "google_compute_router_interface" "aws_cgw3_tunnel1" {
  name       = "${var.name}aws-vpcuser16-cgw-tunnel1"
  router     = "${google_compute_router.cloud_router.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_aws_cgw3_tunnel1.name}"
  ip_range = "${data.terraform_remote_state.aws_eu_w1_vpc1.gcp_cgw3_tunnel1_cgw_inside_address}/30"
  region = "europe-west2"
}

resource "google_compute_router_interface" "aws_cgw3_tunnel2" {
  name       = "${var.name}aws-vpcuser16-cgw-tunnel2"
  router     = "${google_compute_router.cloud_router.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_aws_cgw3_tunnel2.name}"
  ip_range = "${data.terraform_remote_state.aws_eu_w1_vpc1.gcp_cgw3_tunnel2_cgw_inside_address}/30"
  region = "europe-west2"
}

resource "google_compute_router_peer" "aws_cgw3_tunnel1" {
  name                      = "${var.name}aws-vpcuser16-cgw-tunnel1"
  router                    = "${google_compute_router.cloud_router.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_eu_w1_vpc1.aws_cgw3_tunnel1_vgw_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 201
  interface                 = "${google_compute_router_interface.aws_cgw3_tunnel1.name}"
  region = "europe-west2"
}

resource "google_compute_router_peer" "aws_cgw3_tunnel2" {
  name                      = "${var.name}aws-vpcuser16-cgw-tunnel2"
  router                    = "${google_compute_router.cloud_router.name}"
  peer_ip_address           = "${data.terraform_remote_state.aws_eu_w1_vpc1.aws_cgw3_tunnel2_vgw_inside_address}"
  peer_asn                  = 65010
  #advertised_route_priority = 251
  interface                 = "${google_compute_router_interface.aws_cgw3_tunnel2.name}"
  region = "europe-west2"
}
