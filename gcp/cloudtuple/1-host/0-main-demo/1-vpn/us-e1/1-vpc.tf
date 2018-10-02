# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "gcp_us_e1_vpn_gw1_ip" {
  name = "${var.name}gcp-us-e1-vpn-gw1-ip"
  region = "us-east1"
}
