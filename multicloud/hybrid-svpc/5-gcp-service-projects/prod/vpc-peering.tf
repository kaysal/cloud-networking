
resource "google_compute_network_peering" "peering_to_test_service_project" {
  name = "peering-to-test-service-project"
  network = "${google_compute_network.vpc.self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/${var.name}${var.test_peer_project_id}/global/networks/${var.name}${var.test_peer_project_vpc_name}"
}

resource "google_compute_network_peering" "peering_to_netsec_host_project" {
  name = "peering-to-netsec-host-project"
  network = "${google_compute_network.vpc.self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/${var.name}${var.netsec_peer_project_id}/global/networks/${var.name}${var.netsec_peer_project_vpc_name}"
}
