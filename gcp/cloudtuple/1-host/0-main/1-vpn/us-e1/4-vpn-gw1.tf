locals {
  cgw1_tunnel1_ip = "${data.terraform_remote_state.aws_us_e1_vpc1.aws_cgw1_tunnel1_address}"
  cgw1_tunnel2_ip = "${data.terraform_remote_state.aws_us_e1_vpc1.aws_cgw1_tunnel2_address}"
}

# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "us_e1_vpn_gw1" {
  name    = "${var.name}us-e1-vpn-gw1"
  network = "${data.google_compute_network.vpc.self_link}"
  region  = "us-east1"
}

# us-east1 vpn gw1
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp_vpn_gw1_ip_us_e1" {
  name        = "${var.name}fr-esp-vpn-gw1-ip-us-e1"
  ip_protocol = "ESP"
  ip_address  = "${data.google_compute_address.vpn_gw1_ip_us_e1.address}"
  target      = "${google_compute_vpn_gateway.us_e1_vpn_gw1.self_link}"
  region      = "us-east1"
}

resource "google_compute_forwarding_rule" "fr_udp500_vpn_gw1_ip_us_e1" {
  name        = "${var.name}fr-udp500-vpn-gw1-ip-us-e1"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.google_compute_address.vpn_gw1_ip_us_e1.address}"
  target      = "${google_compute_vpn_gateway.us_e1_vpn_gw1.self_link}"
  region      = "us-east1"
}

resource "google_compute_forwarding_rule" "fr_udp4500_vpn_gw1_ip_us_e1" {
  name        = "${var.name}fr-udp4500-vpn-gw1-ip-us-e1"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.google_compute_address.vpn_gw1_ip_us_e1.address}"
  target      = "${google_compute_vpn_gateway.us_e1_vpn_gw1.self_link}"
  region      = "us-east1"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_aws_us_e1_vpc1_cgw1_tunnel1" {
  name               = "to-aws-us-e1-vpc1-cgw1-tunnel1"
  peer_ip            = "${local.cgw1_tunnel1_ip}"
  ike_version        = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.us_e1_vpn_gw1.self_link}"
  router             = "${google_compute_router.us_e1_cr_vpn_vpc.name}"
  region             = "us-east1"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_vpn_gw1_ip_us_e1",
    "google_compute_forwarding_rule.fr_udp500_vpn_gw1_ip_us_e1",
    "google_compute_forwarding_rule.fr_udp4500_vpn_gw1_ip_us_e1",
  ]
}

resource "google_compute_vpn_tunnel" "to_aws_us_e1_vpc1_cgw1_tunnel2" {
  name               = "to-aws-us-e1-vpc1-cgw1-tunnel2"
  peer_ip            = "${local.cgw1_tunnel2_ip}"
  ike_version        = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.us_e1_vpn_gw1.self_link}"
  router             = "${google_compute_router.us_e1_cr_vpn_vpc.name}"
  region             = "us-east1"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_vpn_gw1_ip_us_e1",
    "google_compute_forwarding_rule.fr_udp500_vpn_gw1_ip_us_e1",
    "google_compute_forwarding_rule.fr_udp4500_vpn_gw1_ip_us_e1",
  ]
}
