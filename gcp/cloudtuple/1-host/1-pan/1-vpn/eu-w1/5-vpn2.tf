# VPN B
#================================

# VPN Gateway
#------------------------------
resource "google_compute_vpn_gateway" "eu_w1_vpn_gw2" {
  name    = "${var.name}eu-w1-vpn-gw2"
  network = "${data.terraform_remote_state.untrust.vpc_untrust}"
  region  = "europe-west1"
}

# Forwarding rules for ESP, UDP500 and UDP4500
#------------------------------
resource "google_compute_forwarding_rule" "fr_esp_eu_w1_vpn_gw2" {
  name        = "${var.name}fr-esp-eu-w1-vpn-gw2"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.eu_w1_vpn_gw2_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w1_vpn_gw2.self_link}"
  region      = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_udp500_eu_w1_vpn_gw2" {
  name        = "${var.name}fr-udp500-eu-w1-vpn-gw2"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.eu_w1_vpn_gw2_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w1_vpn_gw2.self_link}"
  region      = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_udp4500_eu_w1_vpn_gw2" {
  name        = "${var.name}fr-udp4500-eu-w1-vpn-gw2"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.eu_w1_vpn_gw2_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w1_vpn_gw2.self_link}"
  region      = "europe-west1"
}

# VPN tunnel
#------------------------------
resource "google_compute_vpn_tunnel" "aws_eu_w1_vpc1_tunnel2" {
  name               = "${var.name}aws-eu-w1-vpc1-tunnel2"
  peer_ip            = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_tunnel_address}"
  ike_version        = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w1_vpn_gw2.self_link}"
  router             = "${google_compute_router.eu_w1_cr_vpn.name}"
  region             = "europe-west1"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_eu_w1_vpn_gw2",
    "google_compute_forwarding_rule.fr_udp500_eu_w1_vpn_gw2",
    "google_compute_forwarding_rule.fr_udp4500_eu_w1_vpn_gw2",
  ]
}
