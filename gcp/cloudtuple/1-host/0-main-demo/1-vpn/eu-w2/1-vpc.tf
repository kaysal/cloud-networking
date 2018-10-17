# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_eu_w2_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w2-vpn-gw1-ip"
  region = "europe-west2"
}

data "google_compute_address" "gcp_eu_w2_vpn_gw2_ip" {
  name = "${var.name}gcp-eu-w2-vpn-gw2-ip"
  region = "europe-west2"
}

data "google_compute_address" "gcp_eu_w2_vpn_gw3_ip" {
  name = "${var.name}gcp-eu-w2-vpn-gw3-ip"
  region = "europe-west2"
}
