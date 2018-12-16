# network data
output "vpc" {
  value = "${google_compute_network.vpc.self_link}"
}

# subnet data
output "apple_eu_w1_10_100_10" {
  value = "${google_compute_subnetwork.apple_eu_w1_10_100_10.self_link}"
}

output "apple_eu_w2_10_150_10" {
  value = "${google_compute_subnetwork.apple_eu_w2_10_150_10.self_link}"
}

output "apple_eu_w3_10_200_10" {
  value = "${google_compute_subnetwork.apple_eu_w3_10_200_10.self_link}"
}

output "gke_eu_w1_10_0_4" {
  value = "${google_compute_subnetwork.gke_eu_w1_10_0_4.self_link}"
}

output "gke_eu_w2_10_0_8" {
  value = "${google_compute_subnetwork.gke_eu_w2_10_0_8.self_link}"
}

output "apple_us_e1_10_250_10" {
  value = "${google_compute_subnetwork.apple_us_e1_10_250_10.self_link}"
}

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

output "gcp_eu_w2_vpn_gw1_ip" {
  value = "${google_compute_address.gcp_eu_w2_vpn_gw1_ip.address}"
}
/*
output "gcp_eu_w3_vpn_gw1_ip" {
  value = "${google_compute_address.gcp_eu_w3_vpn_gw1_ip.address}"
}*/

# public ip address of local machine
output "onprem_ip" {
  value = "${data.external.onprem_ip.result.ip}"
}
