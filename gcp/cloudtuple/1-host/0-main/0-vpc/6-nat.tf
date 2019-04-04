# Cloud Router
#------------------------------
resource "google_compute_router" "eu_w1_cr_nat_vpc" {
  name    = "${var.main}eu-w1-cr-nat-vpc"
  network = "${google_compute_network.vpc.self_link}"
  region  = "europe-west1"
}

resource "google_compute_router" "eu_w2_cr_nat_vpc" {
  name    = "${var.main}eu-w2-cr-nat-vpc"
  network = "${google_compute_network.vpc.self_link}"
  region  = "europe-west2"
}

resource "google_compute_router" "eu_w3_cr_nat_vpc" {
  name    = "${var.main}eu-w3-cr-nat-vpc"
  network = "${google_compute_network.vpc.self_link}"
  region  = "europe-west3"
}

resource "google_compute_router" "us_e1_cr_nat_vpc" {
  name    = "${var.main}us-e1-cr-nat-vpc"
  network = "${google_compute_network.vpc.self_link}"
  region  = "us-east1"
}

# Cloud NAT
#------------------------------
resource "google_compute_router_nat" "eu_w1_nat_vpc" {
  name                               = "eu-w1-nat-vpc"
  router                             = "${google_compute_router.eu_w1_cr_nat_vpc.name}"
  region                             = "europe-west1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_router_nat" "eu_w2_nat_vpc" {
  name                               = "eu-w2-nat-vpc"
  router                             = "${google_compute_router.eu_w2_cr_nat_vpc.name}"
  region                             = "europe-west2"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_router_nat" "eu_w3_nat_vpc" {
  name                               = "eu-w3-nat-vpc"
  router                             = "${google_compute_router.eu_w3_cr_nat_vpc.name}"
  region                             = "europe-west3"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_router_nat" "us_e1_nat_vpc" {
  name                               = "us-e1-nat-vpc"
  router                             = "${google_compute_router.us_e1_cr_nat_vpc.name}"
  region                             = "us-east1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
