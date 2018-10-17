# network
output "vpc" {
  value = "${google_compute_network.vpc.self_link}"
}

output "eu_w2_10_200_20" {
  value = "${google_compute_subnetwork.eu_w2_10_200_20.self_link}"
}

output "eu_w2_vpn_gw_ip" {
  value = "${google_compute_address.eu_w2_vpn_gw_ip.address}"
}