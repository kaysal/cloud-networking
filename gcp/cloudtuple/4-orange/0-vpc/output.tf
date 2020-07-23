# network
output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "eu_w1_10_200_20" {
  value = google_compute_subnetwork.eu_w1_10_200_20.self_link
}

output "gke_eu_w1_10_0_12" {
  value = google_compute_subnetwork.gke_eu_w1_10_0_12.self_link
}

output "gke_eu_w2_10_0_16" {
  value = google_compute_subnetwork.gke_eu_w2_10_0_16.self_link
}

output "eu_w1_vpn_gw_ip" {
  value = google_compute_address.eu_w1_vpn_gw_ip.address
}
