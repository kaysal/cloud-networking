# VPC Demo VPN tunnel
#----------------------------------------------
resource "google_compute_vpn_tunnel" "tunnel_demo_to_onprem" {
  count              = "${var.users}"
  name               = "tunnel-demo-to-onprem"
  region             = "us-central1"
  project            = "${var.rand}-user${count.index+1}-${var.suffix}"
  peer_ip            = "${element(data.google_compute_address.vpc_onprem_gw_ip.*.address, count.index)}"
  shared_secret      = "password123"
  target_vpn_gateway = "${element(google_compute_vpn_gateway.vpc_demo_vpn_gateway.*.self_link, count.index)}"
  router             = "vpc-demo-router"
  ike_version        = 2

  depends_on = [
    "google_compute_forwarding_rule.vpc_demo_vpn_esp",
    "google_compute_forwarding_rule.vpc_demo_vpn_udp500",
    "google_compute_forwarding_rule.vpc_demo_vpn_udp4500",
  ]
}

# VPC onprem VPN tunnel
#----------------------------------------------
resource "google_compute_vpn_tunnel" "tunnel_onprem_to_demo" {
  count              = "${var.users}"
  name               = "tunnel-onprem-to-demo"
  region             = "us-central1"
  project            = "${var.rand}-user${count.index+1}-${var.suffix}"
  peer_ip            = "${element(data.google_compute_address.vpc_demo_gw_ip.*.address, count.index)}"
  shared_secret      = "password123"
  target_vpn_gateway = "${element(google_compute_vpn_gateway.vpc_onprem_vpn_gateway.*.self_link, count.index)}"
  router             = "vpc-onprem-router"
  ike_version        = 2

  depends_on = [
    "google_compute_forwarding_rule.vpc_onprem_vpn_esp",
    "google_compute_forwarding_rule.vpc_onprem_vpn_udp500",
    "google_compute_forwarding_rule.vpc_onprem_vpn_udp4500",
  ]
}
