# cloud router interface to host project
resource "google_compute_router_interface" "to_host" {
  name       = "${var.name}to-host"
  router     = "${google_compute_router.eu_w2_cr1.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_host.name}"
  ip_range   = "169.254.200.2/30"
  region     = "europe-west2"
}

# bgp peer session to host project
resource "google_compute_router_peer" "to_host" {
  name            = "${var.name}to-host"
  router          = "${google_compute_router.eu_w2_cr1.name}"
  peer_ip_address = "169.254.200.1"
  peer_asn        = 65000
  interface       = "${google_compute_router_interface.to_host.name}"
  region          = "europe-west2"
}
