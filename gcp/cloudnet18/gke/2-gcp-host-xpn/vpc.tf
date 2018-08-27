# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "hostnet" {
  name                    = "${var.name}hostnet"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "config_gen" {
  name                    = "${var.name}config-gen"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "hostsubnet_us" {
  name          = "${var.name}hostsubnet-us"
  ip_cidr_range = "192.168.128.0/24"
  network       = "${google_compute_network.hostnet.self_link}"
  region        = "us-central1"
}

resource "google_compute_subnetwork" "hostsubnet_us_east1" {
  name          = "${var.name}hostsubnet-us-east1"
  ip_cidr_range = "192.168.120.0/24"
  network       = "${google_compute_network.hostnet.self_link}"
  region        = "us-east1"
}

resource "google_compute_subnetwork" "hostsubnet_eu" {
  name          = "${var.name}hostsubnet-eu"
  ip_cidr_range = "192.168.132.0/24"
  network       = "${google_compute_network.hostnet.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "config_gen" {
  name          = "${var.name}config-gen"
  ip_cidr_range = "192.168.254.0/24"
  network       = "${google_compute_network.config_gen.self_link}"
  region        = "us-east1"
}
