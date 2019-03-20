resource "google_compute_global_address" "private_ip_alloc" {
  provider      = "google-beta"
  name          = "google-reserved-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "${google_compute_network.vpc.self_link}"
}

/*
resource "google_service_networking_connection" "svc_net_connection" {
  provider = "google-beta"
  network                 = "${google_compute_network.vpc.self_link}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_alloc.name}"]
}
*/

