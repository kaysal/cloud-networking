# Cloud Router
#------------------------------
resource "google_compute_router" "eu_w1_cr_nat" {
  name    = "${var.main}eu-w1-cr-nat"
  network = "${google_compute_network.vpc.self_link}"
  region  = "europe-west1"
}

# Cloud NAT
#------------------------------
resource "google_compute_router_nat" "eu_w1_nat" {
  name                               = "${var.main}eu-w1-nat"
  router                             = "${google_compute_router.eu_w1_cr_nat.name}"
  region                             = "europe-west1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
