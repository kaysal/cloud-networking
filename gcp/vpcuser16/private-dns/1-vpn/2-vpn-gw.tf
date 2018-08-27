
# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "vpn_gateway" {
  name    = "${var.name}vpn-gateway"
  network = "${data.terraform_remote_state.vpc.vpc}"
  region = "europe-west2"
}

# europe-west2 vpn gw1
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "${var.name}fr-esp"
  ip_protocol = "ESP"
  ip_address  = "${data.terraform_remote_state.vpc.vpcuser16_vpn_gw_ip}"
  target      = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "${var.name}fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${data.terraform_remote_state.vpc.vpcuser16_vpn_gw_ip}"
  target      = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
  region = "europe-west2"
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "${var.name}fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${data.terraform_remote_state.vpc.vpcuser16_vpn_gw_ip}"
  target      = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
  region = "europe-west2"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_aws_vpcuser16_cgw_tunnel1" {
  name               = "to-aws-vpcuser16-cgw-tunnel1"
  peer_ip = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.aws_vpcuser16_cgw_tunnel1_address}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
  router = "${google_compute_router.cloud_router.name}"
  region = "europe-west2"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp",
    "google_compute_forwarding_rule.fr_udp500",
    "google_compute_forwarding_rule.fr_udp4500",
  ]
}

resource "google_compute_vpn_tunnel" "to_aws_vpcuser16_cgw_tunnel2" {
  name               = "to-aws-vpcuser16-cgw-tunnel2"
  peer_ip = "${data.terraform_remote_state.aws_eu_west2_vpc1_data.aws_vpcuser16_cgw_tunnel2_address}"
  ike_version = "1"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpn_gateway.self_link}"
  router = "${google_compute_router.cloud_router.name}"
  region = "europe-west2"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp",
    "google_compute_forwarding_rule.fr_udp500",
    "google_compute_forwarding_rule.fr_udp4500",
  ]
}
