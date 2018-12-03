data "google_compute_address" "eu_w2_vpn_gw1_ip" {
  name = "${var.name}eu-w2-vpn-gw1-ip"
  region = "europe-west2"
}
