# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_eu_w1_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw1-ip"
  region = "europe-west1"
}

data "google_compute_address" "gcp_eu_w1_vpn_gw2_ip" {
  name = "${var.name}gcp-eu-w1-vpn-gw2-ip"
  region = "europe-west1"
}
