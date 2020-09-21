
output "network" {
  value = {
    vpc3 = google_compute_network.vpc3
  }
  sensitive = true
}

output "subnetwork" {
  value = {
    us = {
      range1   = google_compute_subnetwork.range1
      range2   = google_compute_subnetwork.range2
      range3   = google_compute_subnetwork.range3
      range4   = google_compute_subnetwork.range4
      range5   = google_compute_subnetwork.range5
      range6   = google_compute_subnetwork.range6
      range7   = google_compute_subnetwork.range7
      range8   = google_compute_subnetwork.range8
      range9   = google_compute_subnetwork.range9
      range10  = google_compute_subnetwork.range10
      range0_x = google_compute_subnetwork.range0_x
      range1_x = google_compute_subnetwork.range1_x
      range2_x = google_compute_subnetwork.range2_x
      range3_x = google_compute_subnetwork.range3_x
      range4_x = google_compute_subnetwork.range4_x
      range5_x = google_compute_subnetwork.range5_x
      range6_x = google_compute_subnetwork.range6_x
      range7_x = google_compute_subnetwork.range7_x
    }
  }
  sensitive = true
}

output "vm9_public_ip" {
  value = google_compute_address.vm9_pulbic_ip.address
}

output "vm10_public_ip" {
  value = google_compute_address.vm10_pulbic_ip.address
}
