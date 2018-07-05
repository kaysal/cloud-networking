# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc-prod"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w3_subnet_172_16_55" {
  name          = "${var.name}us-c1-subnet-172-16-55"
  ip_cidr_range = "172.16.55.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west3"
}
