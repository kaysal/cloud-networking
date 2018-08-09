
# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "eu_w1_vpn_gw1" {
  name    = "${var.name}eu-w1-vpn-gw1"
  network = "${data.terraform_remote_state.xpn.global_vpc}"
  region = "europe-west1"
}

# europe-west1 vpn gw1
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp_eu_w1_vpn_gw1" {
  name        = "${var.name}fr-esp-eu-w1-vpn-gw1"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.gcp_eu_w1_vpn_gw1_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w1_vpn_gw1.self_link}"
  region = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_udp500_eu_w1_vpn_gw1" {
  name        = "${var.name}fr-udp500-eu-w1-vpn-gw1"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.gcp_eu_w1_vpn_gw1_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w1_vpn_gw1.self_link}"
  region = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_udp4500_eu_w1_vpn_gw1" {
  name        = "${var.name}fr-udp4500-eu-w1-vpn-gw1"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.gcp_eu_w1_vpn_gw1_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w1_vpn_gw1.self_link}"
  region = "europe-west1"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_aws_eu_w1_vpc1_cgw1_tunnel1" {
  name               = "to-aws-eu-w1-vpc1-cgw1-tunnel1"
  peer_ip            = "${data.terraform_remote_state.aws_eu_west1_vpc1_data.aws_eu_w1_vpc1_cgw1_tunnel1_address}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w1_vpn_gw1.self_link}"
  router = "${google_compute_router.eu_w1_cr1.name}"
  region = "europe-west1"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_eu_w1_vpn_gw1",
    "google_compute_forwarding_rule.fr_udp500_eu_w1_vpn_gw1",
    "google_compute_forwarding_rule.fr_udp4500_eu_w1_vpn_gw1",
  ]
}

resource "google_compute_vpn_tunnel" "to_aws_eu_w1_vpc1_cgw1_tunnel2" {
  name               = "to-aws-eu-w1-vpc1-cgw1-tunnel2"
  peer_ip            = "${data.terraform_remote_state.aws_eu_west1_vpc1_data.aws_eu_w1_vpc1_cgw1_tunnel2_address}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w1_vpn_gw1.self_link}"
  router = "${google_compute_router.eu_w1_cr1.name}"
  region = "europe-west1"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_eu_w1_vpn_gw1",
    "google_compute_forwarding_rule.fr_udp500_eu_w1_vpn_gw1",
    "google_compute_forwarding_rule.fr_udp4500_eu_w1_vpn_gw1",
  ]
}
