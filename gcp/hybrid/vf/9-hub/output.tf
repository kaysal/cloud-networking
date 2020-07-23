
output "hub" {
  value = {
    vpc = {
      untrust = google_compute_network.untrust
      trust1  = google_compute_network.trust1
      trust2  = google_compute_network.trust2
    }
    subnet = {
      spoke1 = google_compute_subnetwork.spoke1_subnet
      spoke2 = google_compute_subnetwork.spoke2_subnet
    }
    vm = {
      eu1_nva1 = google_compute_instance.eu1_nva1
      eu1_nvvf = google_compute_instance.eu1_nvvf
      eu2_nva1 = google_compute_instance.eu2_nva1
      eu2_nvvf = google_compute_instance.eu2_nvvf
    }
  }
  sensitive = true
}
