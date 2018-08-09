# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "vpc" {
  name = "${var.name}vpc"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "my_custom_subnet" {
  name          = "my-custom-subnet"
  ip_cidr_range = "10.10.30.0/24"
  network = "${google_compute_network.vpc.self_link}"
}

resource "google_compute_subnetwork" "my_custom_subnet2" {
  name          = "my-custom-subnet2"
  ip_cidr_range = "10.10.40.0/24"
  network = "${google_compute_network.vpc.self_link}"
}

# Create VPN GW external IP addresses
#--------------------------------------
resource "google_compute_address" "legacy_vpn_gw" {
  name = "${var.name}legacy-vpn-gw"
  region = "europe-west1"
}

resource "google_compute_address" "vpc_vpn_gateway" {
  name = "${var.name}vpc-vpn-gateway"
  region = "europe-west1"
}
