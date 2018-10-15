# network
output "vpc" {
  value = "${google_compute_network.vpc.self_link}"
}

output "mango_subnet" {
  value = "${google_compute_subnetwork.10_200_20.self_link}"
}
