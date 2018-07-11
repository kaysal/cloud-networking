# vpn gw external ip addresses
output "gcp_eu_w1_vpn_gw1_ip" {
  value = ["${google_compute_address.gcp_eu_w1_vpn_gw1_ip.address}"]
}

output "gcp_eu_w1_vpn_gw2_ip" {
  value = ["${google_compute_address.gcp_eu_w1_vpn_gw2_ip.address}"]
}

output "gcp_us_e1_vpn_gw1_ip" {
  value = ["${google_compute_address.gcp_us_e1_vpn_gw1_ip.address}"]
}

output "gcp_us_e1_vpn_gw2_ip" {
  value = ["${google_compute_address.gcp_us_e1_vpn_gw2_ip.address}"]
}

# subnet data
output "eu_w1_subnet_10_10_10" {
  value = "${google_compute_subnetwork.eu_w1_subnet_10_10_10.name}"
}

output "eu_w2_subnet_10_10_20" {
  value = "${google_compute_subnetwork.eu_w2_subnet_10_10_20.name}"
}

output "us_e1_subnet_10_50_10" {
  value = "${google_compute_subnetwork.us_e1_subnet_10_50_10.name}"
}
