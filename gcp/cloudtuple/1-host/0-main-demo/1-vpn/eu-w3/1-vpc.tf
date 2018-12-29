# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_eu_w3_vpn_gw1_ip" {
  name = "${var.name}gcp-eu-w3-vpn-gw1-ip"
  region = "europe-west3"
}