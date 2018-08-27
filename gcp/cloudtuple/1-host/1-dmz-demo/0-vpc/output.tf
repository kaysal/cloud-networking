# network data
output "dmz" {
  value = "${google_compute_network.dmz.self_link}"
}

output "prod" {
  value = "${google_compute_network.prod.self_link}"
}

output "dev" {
  value = "${google_compute_network.dev.self_link}"
}

# subnet data
output "dmz_subnet" {
  value = "${google_compute_subnetwork.dmz_subnet.self_link}"
}

output "prod_subnet" {
  value = "${google_compute_subnetwork.prod_subnet.self_link}"
}

output "dev_subnet" {
  value = "${google_compute_subnetwork.dev_subnet.self_link}"
}

# public ip address of local machine
output "onprem_ip" {
  value = "${data.external.onprem_ip.result.ip}"
}
