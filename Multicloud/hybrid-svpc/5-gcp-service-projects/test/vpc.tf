# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc-test"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "us_c1_subnet_192_168_10" {
  name          = "${var.name}us-c1-subnet-192-168-10"
  ip_cidr_range = "192.168.10.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "us-central1"
}
