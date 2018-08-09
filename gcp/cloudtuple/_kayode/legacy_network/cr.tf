# Cloud routers
resource "google_compute_router" "vpc_cloud_router" {
  name    = "${var.name}vpc-cloud-router"
  network = "${google_compute_network.vpc.self_link}"
  region = "europe-west1"

  bgp {
    asn = 65000
  }
}

# gcp eu-w1-vpn-gw1
resource "google_compute_router_interface" "to_legacy_network" {
  name = "${var.name}to-legacy-network"
  router = "${google_compute_router.vpc_cloud_router.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_legacy_network.name}"
  ip_range = "169.254.169.1/30"
}

resource "google_compute_router_peer" "to_legacy_network" {
  name  = "${var.name}to-legacy-network"
  router = "${google_compute_router.vpc_cloud_router.name}"
  peer_ip_address = "169.254.169.2"
  peer_asn  = 65010
  interface = "${google_compute_router_interface.to_legacy_network.name}"
}
