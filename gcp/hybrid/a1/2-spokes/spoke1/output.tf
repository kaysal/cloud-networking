
output "spoke1" {
  value = {
    vpc    = google_compute_network.spoke1_vpc
    subnet = google_compute_subnetwork.spoke1_subnet
    sa     = google_service_account.spoke1_sa
  }
  sensitive = "true"
}
