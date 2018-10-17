# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "eu_w2_vpn_gw3" {
  name    = "${var.name}eu-w2-vpn-gw3"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "europe-west2"
}

# europe-west2 vpn gw3
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp_eu_w2_vpn_gw3" {
  name        = "${var.name}fr-esp-eu-w2-vpn-gw3"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.gcp_eu_w2_vpn_gw3_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw3.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp500_eu_w2_vpn_gw3" {
  name        = "${var.name}fr-udp500-eu-w2-vpn-gw3"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.gcp_eu_w2_vpn_gw3_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw3.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp4500_eu_w2_vpn_gw3" {
  name        = "${var.name}fr-udp4500-eu-w2-vpn-gw3"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.gcp_eu_w2_vpn_gw3_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw3.self_link}"
  region = "europe-west2"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_lzone2" {
  name               = "${var.name}to-lzone2"
  region = "europe-west2"
  peer_ip            = "${data.terraform_remote_state.lzone2.eu_w2_vpn_gw_ip}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w2_vpn_gw3.self_link}"

  local_traffic_selector  = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]

  depends_on = [
    "google_compute_forwarding_rule.fr_udp500_eu_w2_vpn_gw3",
    "google_compute_forwarding_rule.fr_udp4500_eu_w2_vpn_gw3",
    "google_compute_forwarding_rule.fr_esp_eu_w2_vpn_gw3",
  ]
}

# route through tunnel 1 takes precedence with lower priority
resource "google_compute_route" "route_to_lzone2" {
  name        = "route-to-lzone2"
  dest_range  = "10.200.30.0/24"
  network = "${data.terraform_remote_state.vpc.vpc}"
  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.to_lzone2.self_link}"
  priority    = 90
}
