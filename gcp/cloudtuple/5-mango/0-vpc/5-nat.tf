# Cloud Router
#------------------------------
resource "google_compute_router" "eu_w2_cr_nat" {
  name    = "${var.main}eu-w2-cr-nat"
  network = "${google_compute_network.vpc.self_link}"
  region  = "europe-west2"
}

# Cloud NAT
#------------------------------
resource "google_compute_router_nat" "eu_w2_nat" {
  name                               = "${var.main}eu-w2-nat"
  router                             = "${google_compute_router.eu_w2_cr_nat.name}"
  region                             = "europe-west2"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
