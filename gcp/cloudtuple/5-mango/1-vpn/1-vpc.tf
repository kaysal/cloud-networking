data "google_compute_address" "eu_w2_vpn_gw_ip" {
  name = "${var.main}eu-w2-vpn-gw-ip"
  region = "europe-west2"
}
