# network data
output "hostnet" {
  value = "${google_compute_network.hostnet.self_link}"
}

output "config_gen_network" {
  value = "${google_compute_network.config_gen.self_link}"
}

# subnet data
output "hostsubnet_us" {
  value = "${google_compute_subnetwork.hostsubnet_us.name}"
}

output "hostsubnet_us_east1" {
  value = "${google_compute_subnetwork.hostsubnet_us_east1.name}"
}

output "hostsubnet_eu" {
  value = "${google_compute_subnetwork.hostsubnet_eu.name}"
}

output "config_gen_subnet" {
  value = "${google_compute_subnetwork.config_gen.name}"
}
