
output "network" {
  value = {
    vpc1 = google_compute_network.vpc_spoke1
    subnet = {
      data_eu = google_compute_subnetwork.data_eu
    }
  }
  sensitive = true
}
