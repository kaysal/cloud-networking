# cloud router interface to mango project
resource "google_compute_router_interface" "to_mango" {
  name       = "${var.name}to-mango"
  router     = "${google_compute_router.eu_w2_cr1.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_mango.name}"
  ip_range   = "169.254.200.1/30"
  region     = "europe-west2"
}

# bgp peer session to mango project
resource "google_compute_router_peer" "to_mango" {
  name            = "${var.name}to-mango"
  router          = "${google_compute_router.eu_w2_cr1.name}"
  peer_ip_address = "169.254.200.2"
  peer_asn        = 65010
  interface       = "${google_compute_router_interface.to_mango.name}"
  region          = "europe-west2"
}
