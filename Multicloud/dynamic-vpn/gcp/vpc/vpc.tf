# Create VPC
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "vpc-${var.name}"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w1b_subnet" {
  name          = "${var.name}-eu-w1b-subnet"
  ip_cidr_range = "10.10.10.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "eu_w1c_subnet" {
  name          = "${var.name}-eu-w1c-subnet"
  ip_cidr_range = "10.10.20.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "eu_w3b_subnet" {
  name          = "${var.name}-eu-w3b-subnet"
  ip_cidr_range = "10.10.40.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west3"
}

resource "google_compute_subnetwork" "us_e1b_subnet" {
  name          = "${var.name}-us-e1b-subnet"
  ip_cidr_range = "10.10.60.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "us-east1"
}
