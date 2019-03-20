locals {
  local_vti = "169.254.200.1/30"
  peer_vti = "169.254.200.2"
  peer_asn = 65010
}

# cloud router interface to mango project
resource "google_compute_router_interface" "to_mango" {
  name       = "${var.name}to-mango"
  router     = "${google_compute_router.eu_w2_cr_vpn_vpc.name}"
  vpn_tunnel = "${google_compute_vpn_tunnel.to_mango.name}"
  ip_range   = "${local.local_vti}"
  region     = "europe-west2"
}

# bgp peer session to mango project
resource "google_compute_router_peer" "to_mango" {
  name            = "${var.name}to-mango"
  router          = "${google_compute_router.eu_w2_cr_vpn_vpc.name}"
  peer_ip_address = "${local.peer_vti}"
  peer_asn        = "${local.peer_asn}"
  interface       = "${google_compute_router_interface.to_mango.name}"
  region          = "europe-west2"
}
