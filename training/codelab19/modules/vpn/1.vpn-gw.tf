# VPN Gateways
resource "google_compute_vpn_gateway" "vpc_demo_vpn_gateway" {
  count   = "${var.users}"
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  name    = "vpc-demo-vpn-gateway"
  network = "vpc-demo-${count.index+1}"
  region  = "us-central1"
}

resource "google_compute_vpn_gateway" "vpc_onprem_vpn_gateway" {
  count   = "${var.users}"
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  name    = "vpc-onprem-vpn-gateway"
  network = "vpc-onprem-${count.index+1}"
  region  = "us-central1"
}
