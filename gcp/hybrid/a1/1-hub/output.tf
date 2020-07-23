
output "hub" {
  value = {
    vpc = {
      untrust = google_compute_network.untrust
      trust1  = google_compute_network.trust1
      trust2  = google_compute_network.trust2
    }
    vm = {
      eu1_nva1 = google_compute_instance.eu1_nva1
      eu1_nva2 = google_compute_instance.eu1_nva2
      eu2_nva1 = google_compute_instance.eu2_nva1
      eu2_nva2 = google_compute_instance.eu2_nva2
    }
  }
  sensitive = true
}
