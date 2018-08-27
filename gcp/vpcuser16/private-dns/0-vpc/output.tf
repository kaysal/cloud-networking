# network
output "vpc" {
  value = "${google_compute_network.vpc.self_link}"
}

output "prod_subnet" {
  value = "${google_compute_subnetwork.prod_subnet.self_link}"
}

# vpn gw external ip addresses
output "vpcuser16_vpn_gw_ip" {
  value = "${google_compute_address.vpn_gw_ip.address}"
}
