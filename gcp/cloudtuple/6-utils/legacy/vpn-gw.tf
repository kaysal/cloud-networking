
# vpn configuration
# Attach the VPN gateways to the VPC.
resource "google_compute_vpn_gateway" "vpc_vpn_gateway" {
  name    = "${var.name}vpc-vpn-gateway"
  network       = "${google_compute_network.vpc.self_link}"
}

# europe-west1 vpn gw1
# --------------------------------------------
# Forwarding rules for ESP, UDP500 and UDP4500
resource "google_compute_forwarding_rule" "fr_esp_vpc_vpn_gateway" {
  name        = "${var.name}fr-esp-vpc-vpn-gateway"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.vpc_vpn_gateway.address}"
  target      = "${google_compute_vpn_gateway.vpc_vpn_gateway.self_link}"
  region = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_udp500_vpc_vpn_gateway" {
  name        = "${var.name}fr-udp500-vpc-vpn-gateway"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${google_compute_address.vpc_vpn_gateway.address}"
  target      = "${google_compute_vpn_gateway.vpc_vpn_gateway.self_link}"
}

resource "google_compute_forwarding_rule" "fr_udp4500_vpc_vpn_gateway" {
  name        = "${var.name}fr-udp4500-vpc-vpn-gateway"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${google_compute_address.vpc_vpn_gateway.address}"
  target      = "${google_compute_vpn_gateway.vpc_vpn_gateway.self_link}"
}

# vpn tunnels
resource "google_compute_vpn_tunnel" "to_legacy_network" {
  name               = "to-legacy-network"
  peer_ip            = "${google_compute_address.legacy_vpn_gw.address}"
  ike_version = "2"
  shared_secret      = "${var.preshared_key}"
  target_vpn_gateway = "${google_compute_vpn_gateway.vpc_vpn_gateway.self_link}"
  router = "${google_compute_router.vpc_cloud_router.name}"

  depends_on = [
    "google_compute_forwarding_rule.fr_esp_vpc_vpn_gateway",
    "google_compute_forwarding_rule.fr_udp500_vpc_vpn_gateway",
    "google_compute_forwarding_rule.fr_udp4500_vpc_vpn_gateway",
  ]
}
