locals {
  peer1_tunnel_ip = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_tunnel_address}"
  peer2_tunnel_ip = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_tunnel_address}"
}

# VPN Gateway
#------------------------------
resource "google_compute_vpn_gateway" "vpn_gw_eu_w1" {
  name    = "${var.nva}eu-w1-vpn-gw"
  network = "${data.terraform_remote_state.nva.vpc_untrust}"
  region  = "europe-west1"
}

# Forwarding rules for ESP, UDP500 and UDP4500
#------------------------------
resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "${var.nva}fr-esp"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.vpn_gw_ip_eu_w1.address}"
  target      = "${google_compute_vpn_gateway.vpn_gw_eu_w1.self_link}"
  region      = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "${var.nva}fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.vpn_gw_ip_eu_w1.address}"
  target      = "${google_compute_vpn_gateway.vpn_gw_eu_w1.self_link}"
  region      = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "${var.nva}fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.vpn_gw_ip_eu_w1.address}"
  target      = "${google_compute_vpn_gateway.vpn_gw_eu_w1.self_link}"
  region      = "europe-west1"
}

# VPN tunnel 1
#------------------------------
resource "google_compute_vpn_tunnel" "aws_eu_w1_vpc1_tunnel1" {
  name               = "${var.nva}aws-eu-w1-vpc1-tunnel1"
  peer_ip            = "${local.peer1_tunnel_ip}"
  ike_version        = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn_gw_eu_w1.self_link}"
  router             = "${google_compute_router.eu_w1_cr_vpn.name}"
  region             = "europe-west1"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp",
    "google_compute_forwarding_rule.fr_udp500",
    "google_compute_forwarding_rule.fr_udp4500",
  ]
}

# VPN tunnel 2
#------------------------------
resource "google_compute_vpn_tunnel" "aws_eu_w1_vpc1_tunnel2" {
  name               = "${var.nva}aws-eu-w1-vpc1-tunnel2"
  peer_ip            = "${local.peer2_tunnel_ip}"
  ike_version        = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn_gw_eu_w1.self_link}"
  router             = "${google_compute_router.eu_w1_cr_vpn.name}"
  region             = "europe-west1"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp",
    "google_compute_forwarding_rule.fr_udp500",
    "google_compute_forwarding_rule.fr_udp4500",
  ]
}
