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

output "vpn_gw_ip_eu_w1" {
  value = "${google_compute_address.vpn_gw_ip_eu_w1_.name}"
}
