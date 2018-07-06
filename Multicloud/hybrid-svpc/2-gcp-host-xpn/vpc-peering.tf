
resource "google_compute_network_peering" "peering_to_prod_service_project" {
  name = "peering-to-prod-service-project"
  network = "${google_compute_network.vpc.self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/${var.name}${var.prod_peer_project_id}/global/networks/${var.name}${var.prod_peer_project_vpc_name}"
}
