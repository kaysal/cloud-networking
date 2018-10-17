# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "eu_w2_vpn_gw" {
  name    = "${var.name}eu-w2-vpn-gw"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "europe-west2"
}

# europe-west2 vpn gw
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp_eu_w2_vpn_gw" {
  name        = "${var.name}fr-esp-eu-w2-vpn-gw"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.eu_w2_vpn_gw_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp500_eu_w2_vpn_gw" {
  name        = "${var.name}fr-udp500-eu-w2-vpn-gw"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.eu_w2_vpn_gw_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp4500_eu_w2_vpn_gw" {
  name        = "${var.name}fr-udp4500-eu-w2-vpn-gw"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.eu_w2_vpn_gw_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"
  region = "europe-west2"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_host" {
  name               = "${var.name}to-host"
  region = "europe-west2"
  peer_ip            = "${data.terraform_remote_state.host.gcp_eu_w2_vpn_gw3_ip}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w2_vpn_gw.self_link}"

  local_traffic_selector  = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]

  depends_on = [
    "google_compute_forwarding_rule.fr_udp500_eu_w2_vpn_gw",
    "google_compute_forwarding_rule.fr_udp4500_eu_w2_vpn_gw",
    "google_compute_forwarding_rule.fr_esp_eu_w2_vpn_gw",
  ]
}

# routes
resource "google_compute_route" "route_to_host" {
  name        = "${var.name}route-to-host"
  dest_range  = "10.0.0.0/8"
  network = "${data.terraform_remote_state.vpc.vpc}"
  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.to_host.self_link}"
  priority    = 90
}

resource "google_compute_route" "route_to_aws" {
  name        = "${var.name}route-to-aws"
  dest_range  = "172.0.0.0/8"
  network = "${data.terraform_remote_state.vpc.vpc}"
  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.to_host.self_link}"
  priority    = 90
}
