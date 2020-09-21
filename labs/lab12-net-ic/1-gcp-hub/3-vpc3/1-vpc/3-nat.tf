
# cloud nat
#------------------------------------

# us router

resource "google_compute_router" "vpc3_router_us" {
  name    = "vpc3-router-us"
  region  = var.hub.vpc3.us.region
  network = google_compute_network.vpc3.self_link

  bgp {
    asn = var.hub.vpc3.asn
  }
}

# us nat

resource "google_compute_router_nat" "vpc3_nat_us" {
  name                               = "vpc3-nat-us"
  router                             = google_compute_router.vpc3_router_us.name
  region                             = var.hub.vpc3.us.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  min_ports_per_vm                   = "57344"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = "true"
    filter = "ERRORS_ONLY"
  }
}
