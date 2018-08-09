# Create networks
#--------------------------------------
resource "google_compute_network" "vpc_demo" {
  name                    = "${var.name}vpc-demo"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "demo_subnet1" {
  name          = "${var.name}demo-subnet1"
  ip_cidr_range = "10.1.1.0/24"
  network       = "${google_compute_network.vpc_demo.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "demo_subnet2" {
  name          = "${var.name}demo-subnet2"
  ip_cidr_range = "10.1.2.0/24"
  network       = "${google_compute_network.vpc_demo.self_link}"
  region        = "europe-west1"
}
