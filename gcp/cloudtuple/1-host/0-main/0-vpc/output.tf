# network data
output "vpc_name" {
  value = google_compute_network.vpc.name
}

# subnet data
output "apple_eu_w1_10_100_10" {
  value = google_compute_subnetwork.apple_eu_w1_10_100_10.self_link
}

output "apple_eu_w2_10_150_10" {
  value = google_compute_subnetwork.apple_eu_w2_10_150_10.self_link
}

output "apple_eu_w3_10_200_10" {
  value = google_compute_subnetwork.apple_eu_w3_10_200_10.self_link
}

output "gke_eu_w1_10_0_4" {
  value = google_compute_subnetwork.gke_eu_w1_10_0_4.self_link
}

output "gke_eu_w2_10_0_8" {
  value = google_compute_subnetwork.gke_eu_w2_10_0_8.self_link
}

output "apple_us_e1_10_250_10" {
  value = google_compute_subnetwork.apple_us_e1_10_250_10.self_link
}

# vpn gw external ip address values
output "vpn_gw_ip_eu_w1_addr" {
  value = google_compute_address.vpn_gw_ip_eu_w1.address
}

output "vpn_gw_ip_eu_w2_addr" {
  value = google_compute_address.vpn_gw_ip_eu_w2.address
}

output "vpn_gw1_ip_us_e1_addr" {
  value = google_compute_address.vpn_gw1_ip_us_e1.address
}

output "vpn_gw2_ip_us_e1_addr" {
  value = google_compute_address.vpn_gw2_ip_us_e1.address
}

# vpn gw external ip address names
output "vpn_gw_ip_eu_w1_name" {
  value = google_compute_address.vpn_gw_ip_eu_w1.name
}

output "vpn_gw_ip_eu_w2_name" {
  value = google_compute_address.vpn_gw_ip_eu_w2.name
}

output "vpn_gw1_ip_us_e1_name" {
  value = google_compute_address.vpn_gw1_ip_us_e1.name
}

output "vpn_gw2_ip_us_e1_name" {
  value = google_compute_address.vpn_gw2_ip_us_e1.name
}

/*
output "gcp_eu_w3_vpn_gw1_ip" {
  value = "${google_compute_address.gcp_eu_w3_vpn_gw1_ip.address}"
}*/

# public ip address of local machine
output "onprem_ip" {
  value = data.external.onprem_ip.result.ip
}

# dns outputs
output "public_host_cloudtuple_name" {
  value = google_dns_managed_zone.public_host_cloudtuple.name
}

