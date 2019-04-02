# network
output "vpc_name" {
  value = "${google_compute_network.vpc.name}"
}

output "eu_w2_10_200_30" {
  value = "${google_compute_subnetwork.eu_w2_10_200_30.self_link}"
}

output "eu_w2_vpn_gw_ip" {
  value = "${google_compute_address.eu_w2_vpn_gw_ip.address}"
}

output "policy_based_vpn_gw_ip" {
  value = "${google_compute_address.policy_based_vpn_gw_ip.address}"
}
