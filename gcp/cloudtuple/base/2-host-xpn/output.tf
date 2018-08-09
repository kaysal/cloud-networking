# vpn gw external ip addresses
output "gcp_eu_w1_vpn_gw1_ip" {
  value = "${google_compute_address.gcp_eu_w1_vpn_gw1_ip.address}"
}

output "gcp_eu_w1_vpn_gw2_ip" {
  value = "${google_compute_address.gcp_eu_w1_vpn_gw2_ip.address}"
}

output "gcp_us_e1_vpn_gw1_ip" {
  value = "${google_compute_address.gcp_us_e1_vpn_gw1_ip.address}"
}

output "gcp_us_e1_vpn_gw2_ip" {
  value = "${google_compute_address.gcp_us_e1_vpn_gw2_ip.address}"
}

# subnet data
output "eu_w1_subnet_10_100_10" {
  value = "${google_compute_subnetwork.eu_w1_subnet_10_100_10.self_link}"
}

output "eu_w2_subnet_10_100_20" {
  value = "${google_compute_subnetwork.eu_w2_subnet_10_100_20.self_link}"
}

output "us_e1_subnet_10_120_10" {
  value = "${google_compute_subnetwork.us_e1_subnet_10_120_10.self_link}"
}

output "k8s_subnet_10_0_8" {
  value = "${google_compute_subnetwork.k8s_subnet_10_0_8.self_link}"
}

# network data
output "global_vpc" {
  value = "${google_compute_network.global_vpc.self_link}"
}
