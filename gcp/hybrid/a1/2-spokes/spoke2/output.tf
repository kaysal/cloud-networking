
output "spoke2" {
  value = {
    vpc    = google_compute_network.spoke2_vpc
    subnet = google_compute_subnetwork.spoke2_subnet
    sa     = google_service_account.spoke2_sa
  }
  sensitive = "true"
}
