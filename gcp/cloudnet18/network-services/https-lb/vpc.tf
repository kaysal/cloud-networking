# Create networks
#--------------------------------------
resource "google_compute_network" "dmz" {
  name                    = "${var.name}dmz"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "prod" {
  name                    = "${var.name}prod"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "dev" {
  name                    = "${var.name}dev"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "dmz_subnet" {
  name          = "${var.name}dmz-subnet"
  ip_cidr_range = "10.0.0.0/24"
  network       = "${google_compute_network.dmz.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "prod_subnet" {
  name          = "${var.name}prod-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = "${google_compute_network.prod.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "dev_subnet" {
  name          = "${var.name}dev-subnet"
  ip_cidr_range = "10.0.2.0/24"
  network       = "${google_compute_network.dev.self_link}"
  region        = "europe-west1"
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
