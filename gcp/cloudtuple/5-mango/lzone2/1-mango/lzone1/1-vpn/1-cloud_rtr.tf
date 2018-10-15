# Cloud router
resource "google_compute_router" "cloud_router" {
  name    = "${var.name}cloud-router"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "europe-west2"

  bgp {
    asn = 65001
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    advertised_ip_ranges {
      range = "35.199.192.0/19"
    }

    advertised_ip_ranges {
      range = "199.36.153.4/30"
    }
  }
}

# gcp eu-w2-vpn-gw1
resource "google_compute_router_interface" "to_host" {
  name       = "${var.name}to-host"
  router     = "${google_compute_router.cloud_router.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_host.name}"
  ip_range = "${var.bgp_ip_lzone1}"
  region = "europe-west2"
}

resource "google_compute_router_peer" "to_host" {
  name                      = "${var.name}to-host"
  router                    = "${google_compute_router.cloud_router.name}"
  peer_ip_address           = "${var.bgp_ip_host}"
  peer_asn                  = 65000
  interface                 = "${google_compute_router_interface.aws_vpcuser16_cgw_tunnel1.name}"
  region = "europe-west2"
}
