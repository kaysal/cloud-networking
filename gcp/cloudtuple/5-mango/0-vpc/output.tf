# network
output "vpc_name" {
  value = "${google_compute_network.vpc.name}"
}

output "eu_w2_10_200_30" {
  value = "${google_compute_subnetwork.eu_w2_10_200_30.self_link}"
}

output "vpn_gw_ip_eu_w2_addr" {
  value = "${google_compute_address.vpn_gw_ip_eu_w2.address}"
}

output "policy_based_vpn_gw_ip" {
  value = "${google_compute_address.policy_based_vpn_gw_ip.address}"
}
