# VPC Networks
output "vpc_mgt" {
  value = "${google_compute_network.mgt.self_link}"
}

output "vpc_trust" {
  value = "${google_compute_network.trust.self_link}"
}

output "vpc_untrust" {
  value = "${google_compute_network.untrust.self_link}"
}

# Network Subnets
output "subnet_mgt" {
  value = "${google_compute_subnetwork.mgt.self_link}"
}

output "subnet_trust" {
  value = "${google_compute_subnetwork.trust.self_link}"
}

output "subnet_untrust" {
  value = "${google_compute_subnetwork.untrust.self_link}"
}

output "eu_w1_vpn_gw1_ip" {
  value = "${google_compute_address.eu_w1_vpn_gw1_ip.address}"
}

output "eu_w1_vpn_gw2_ip" {
  value = "${google_compute_address.eu_w1_vpn_gw2_ip.address}"
}
