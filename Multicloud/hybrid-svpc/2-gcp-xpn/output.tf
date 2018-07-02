output "gcp_eu_w1_vpn_gw1_ip" {
  value = ["${google_compute_address.gcp_eu_w1_vpn_gw1_ip.address}"]
}

output "gcp_us_e1_vpn_gw1_ip" {
  value = ["${google_compute_address.gcp_us_e1_vpn_gw1_ip.address}"]
}
