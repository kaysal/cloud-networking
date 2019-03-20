locals {
  peer_ip = "${data.terraform_remote_state.mango.vpn_gw_ip_eu_w2}"
}

# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "eu_w2_vpn_gw" {
  name    = "${var.name}eu-w2-vpn-gw"
  network = "${data.google_compute_network.vpc.self_link}"
  region  = "europe-west2"
}

# europe-west2 vpn gw
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "${var.name}fr-esp"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.vpn_gw_ip_eu_w2.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"
  region      = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "${var.name}fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.vpn_gw_ip_eu_w2.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"
  region      = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "${var.name}fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.vpn_gw_ip_eu_w2.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"
  region      = "europe-west2"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_mango" {
  name               = "${var.name}to-mango"
  region             = "europe-west2"
  peer_ip            = "${local.peer_ip}"
  ike_version        = "2"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"
  router = "${google_compute_router.eu_w2_cr_vpn_vpc.name}"

  depends_on = [
    "google_compute_forwarding_rule.fr_udp500",
    "google_compute_forwarding_rule.fr_udp4500",
    "google_compute_forwarding_rule.fr_esp",
  ]
}
