# VPC Networks
output "vpc_mgt_name" {
  value = "${google_compute_network.mgt.name}"
}

output "vpc_trust_name" {
  value = "${google_compute_network.trust.name}"
}

output "vpc_untrust_name" {
  value = "${google_compute_network.untrust.name}"
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

output "vpn_gw_ip_eu_w1_addr" {
  value = "${google_compute_address.vpn_gw_ip_eu_w1_.address}"
}
