# Cloud Router
#------------------------------
resource "google_compute_router" "eu_w1_cr_nat_trust" {
  name    = "${var.name}eu-w1-cr-nat-trust"
  network = "${google_compute_network.trust.self_link}"
  region  = "europe-west1"
}

# Cloud NAT
#------------------------------
resource "google_compute_router_nat" "eu_w1_nat_trust" {
  name                               = "${var.name}eu-w2-nat-trust"
  router                             = "${google_compute_router.eu_w1_cr_nat_trust.name}"
  region                             = "europe-west1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
