# VPC Demo Forwarding Rules
#----------------------------------------------
resource "google_compute_forwarding_rule" "vpc_demo_vpn_esp" {
  count       = "${var.users}"
  name        = "vpc-demo-fr-esp"
  ip_protocol = "ESP"
  ip_address  = "${element(data.google_compute_address.vpc_demo_gw_ip.*.address, count.index)}"
  target      = "${element(google_compute_vpn_gateway.vpc_demo_vpn_gateway.*.self_link, count.index)}"
  project     = "${var.rand}-user${count.index+1}-${var.suffix}"
  region      = "us-central1"
}

resource "google_compute_forwarding_rule" "vpc_demo_vpn_udp500" {
  count       = "${var.users}"
  name        = "vpc-demo-fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${element(data.google_compute_address.vpc_demo_gw_ip.*.address, count.index)}"
  target      = "${element(google_compute_vpn_gateway.vpc_demo_vpn_gateway.*.self_link, count.index)}"
  project     = "${var.rand}-user${count.index+1}-${var.suffix}"
  region      = "us-central1"
}

resource "google_compute_forwarding_rule" "vpc_demo_vpn_udp4500" {
  count       = "${var.users}"
  name        = "vpc-demo-fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${element(data.google_compute_address.vpc_demo_gw_ip.*.address, count.index)}"
  target      = "${element(google_compute_vpn_gateway.vpc_demo_vpn_gateway.*.self_link, count.index)}"
  project     = "${var.rand}-user${count.index+1}-${var.suffix}"
  region      = "us-central1"
}

# VPC onprem Forwarding Rules
#----------------------------------------------
resource "google_compute_forwarding_rule" "vpc_onprem_vpn_esp" {
  count       = "${var.users}"
  name        = "vpc-onprem-fr-esp"
  ip_protocol = "ESP"
  ip_address  = "${element(data.google_compute_address.vpc_onprem_gw_ip.*.address, count.index)}"
  target      = "${element(google_compute_vpn_gateway.vpc_onprem_vpn_gateway.*.self_link, count.index)}"
  project     = "${var.rand}-user${count.index+1}-${var.suffix}"
  region      = "us-central1"
}

resource "google_compute_forwarding_rule" "vpc_onprem_vpn_udp500" {
  count       = "${var.users}"
  name        = "vpc-onprem-fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${element(data.google_compute_address.vpc_onprem_gw_ip.*.address, count.index)}"
  target      = "${element(google_compute_vpn_gateway.vpc_onprem_vpn_gateway.*.self_link, count.index)}"
  project     = "${var.rand}-user${count.index+1}-${var.suffix}"
  region      = "us-central1"
}

resource "google_compute_forwarding_rule" "vpc_onprem_vpn_udp4500" {
  count       = "${var.users}"
  name        = "vpc-onprem-fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${element(data.google_compute_address.vpc_onprem_gw_ip.*.address, count.index)}"
  target      = "${element(google_compute_vpn_gateway.vpc_onprem_vpn_gateway.*.self_link, count.index)}"
  project     = "${var.rand}-user${count.index+1}-${var.suffix}"
  region      = "us-central1"
}
