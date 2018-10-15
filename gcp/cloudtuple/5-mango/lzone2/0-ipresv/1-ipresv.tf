# VPN GW external IP
#--------------------------------------
resource "google_compute_address" "lzone2_vpn_gw_ip" {
  name = "lzone1-vpn-gw-ip"
  region = "europe-west2"
}
