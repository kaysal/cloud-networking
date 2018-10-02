
# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "eu_w2_vpn_gw2" {
  name    = "${var.name}eu-w2-vpn-gw2"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "europe-west2"
}

# europe-west2 vpn gw2
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp_eu_w2_vpn_gw2" {
  name        = "${var.name}fr-esp-eu-w2-vpn-gw2"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.gcp_eu_w2_vpn_gw2_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw2.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp500_eu_w2_vpn_gw2" {
  name        = "${var.name}fr-udp500-eu-w2-vpn-gw2"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.gcp_eu_w2_vpn_gw2_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw2.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp4500_eu_w2_vpn_gw2" {
  name        = "${var.name}fr-udp4500-eu-w2-vpn-gw2"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.gcp_eu_w2_vpn_gw2_ip.address}"
  target      = "${google_compute_vpn_gateway.eu_w2_vpn_gw2.self_link}"
  region = "europe-west2"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_aws_eu_w2_vpc1_cgw2_tunnel1" {
  name               = "to-aws-eu-w2-vpc1-cgw2-tunnel1"
  peer_ip            = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.aws_eu_w2_vpc1_cgw2_tunnel1_address}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w2_vpn_gw2.self_link}"
  router = "${google_compute_router.eu_w2_cr2.name}"
  region = "europe-west2"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_eu_w2_vpn_gw2",
    "google_compute_forwarding_rule.fr_udp500_eu_w2_vpn_gw2",
    "google_compute_forwarding_rule.fr_udp4500_eu_w2_vpn_gw2",
  ]
}

resource "google_compute_vpn_tunnel" "to_aws_eu_w2_vpc1_cgw2_tunnel2" {
  name               = "to-aws-eu-w2-vpc1-cgw2-tunnel2"
  peer_ip            = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.aws_eu_w2_vpc1_cgw2_tunnel2_address}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.eu_w2_vpn_gw2.self_link}"
  router = "${google_compute_router.eu_w2_cr2.name}"
  region = "europe-west2"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_eu_w2_vpn_gw2",
    "google_compute_forwarding_rule.fr_udp500_eu_w2_vpn_gw2",
    "google_compute_forwarding_rule.fr_udp4500_eu_w2_vpn_gw2",
  ]
}
