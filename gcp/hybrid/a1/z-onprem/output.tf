
output "onprem" {
  value = {
    vpc = google_compute_network.onprem
    sa  = google_service_account.onprem_sa
    subnet = {
      onprem_eu1 = google_compute_subnetwork.onprem_eu1
      onprem_eu2 = google_compute_subnetwork.onprem_eu2
    }
  }
  sensitive = "true"
}
