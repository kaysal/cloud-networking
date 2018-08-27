# Create networks
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "blue_eu_w1_subnet" {
  name          = "${var.name}blue-eu-w1-subnet"
  ip_cidr_range = "10.0.10.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "green_eu_w1_subnet" {
  name          = "${var.name}green-eu-w1-subnet"
  ip_cidr_range = "10.0.20.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "blue_eu_w2_subnet" {
  name          = "${var.name}blue-eu-w2-subnet"
  ip_cidr_range = "10.0.30.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west2"
}

resource "google_compute_subnetwork" "green_eu_w2_subnet" {
  name          = "${var.name}green-eu-w2-subnet"
  ip_cidr_range = "10.0.40.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west2"
}

resource "google_compute_subnetwork" "dev_us_e1_subnet" {
  name          = "${var.name}green-us-e1-subnet"
  ip_cidr_range = "10.0.50.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "us-east1"
}


# gclb global static ip address
#--------------------------------------
resource "google_compute_global_address" "gclb_ipv4" {
  name = "${var.name}gclb-ipv4"
  description = "static ipv4 address for gclb frontend"
}

resource "google_compute_global_address" "gclb_ipv6" {
  name = "${var.name}gclb-ipv6"
  description = "static ipv6 address for gclb frontend"
  ip_version = "IPV6"
}

data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
