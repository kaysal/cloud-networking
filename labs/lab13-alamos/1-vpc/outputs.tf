
output "vpc" {
  value     = google_compute_network.vpc_alamos
  sensitive = true
}

output "subnet" {
  value     = google_compute_subnetwork.jump_subnet
  sensitive = true
}
