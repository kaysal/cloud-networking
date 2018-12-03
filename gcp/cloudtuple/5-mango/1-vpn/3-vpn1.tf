# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "eu_w2_vpn_gw1" {
  name    = "${var.name}eu-w2-vpn-gw1"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region  = "europe-west2"
}

# europe-west2 vpn gw1
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp_eu_w2_vpn_gw1" {
  name        = "${var.name}fr-esp-eu-w2-vpn-gw1"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.eu_w2_vpn_gw1_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw1.self_link}"
  region      = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp500_eu_w2_vpn_gw1" {
  name        = "${var.name}fr-udp500-eu-w2-vpn-gw1"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.eu_w2_vpn_gw1_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw1.self_link}"
  region      = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp4500_eu_w2_vpn_gw1" {
  name        = "${var.name}fr-udp4500-eu-w2-vpn-gw1"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.eu_w2_vpn_gw1_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw1.self_link}"
  region      = "europe-west2"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_host" {
  name               = "${var.name}to-host"
  region             = "europe-west2"
  peer_ip            = "${data.terraform_remote_state.host.gcp_eu_w2_vpn_gw1_ip}"
  ike_version        = "2"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w2_vpn_gw1.self_link}"
  router = "${google_compute_router.eu_w2_cr1.name}"

  depends_on = [
    "google_compute_forwarding_rule.fr_udp500_eu_w2_vpn_gw1",
    "google_compute_forwarding_rule.fr_udp4500_eu_w2_vpn_gw1",
    "google_compute_forwarding_rule.fr_esp_eu_w2_vpn_gw1",
  ]
}
