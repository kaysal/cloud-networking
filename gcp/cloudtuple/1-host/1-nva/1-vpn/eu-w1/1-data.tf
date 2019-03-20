# Retrieve vpn gateway external IP addresses
#--------------------------------------
data "google_compute_address" "vpn_gw_ip_eu_w1" {
  name   = "${data.terraform_remote_state.nva.vpn_gw_ip_eu_w1}"
  region = "europe-west1"
}
