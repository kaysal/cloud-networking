
# Create VPC
#--------------------------------------
resource "google_compute_network" "networking_101" {
  name                    = "networking-101"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "us_west1_s1" {
  name          = "us-west1-s1"
  ip_cidr_range = "10.10.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "us-west1"
}

resource "google_compute_subnetwork" "us_west1_s2" {
  name          = "us-west1-s2"
  ip_cidr_range = "10.11.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "us-west1"
}

resource "google_compute_subnetwork" "us_east1" {
  name          = "us-east1"
  ip_cidr_range = "10.20.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "us-east1"
}

resource "google_compute_subnetwork" "europe_west1" {
  name          = "europe-west1"
  ip_cidr_range = "10.30.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "asia_east1" {
  name          = "asia-east1"
  ip_cidr_range = "10.40.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "asia-east1"
}

# Create firewall rules
#--------------------------------------
resource "google_compute_firewall" "fw_allow_internal" {
  name    = "${var.name}-allow-internal"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "fw_allow_ssh" {
  name    = "${var.name}-allow-ssh"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "fw_allow_icmp" {
  name    = "${var.name}-allow-icmp"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

# allow gfe (130.211.0.0/22 and 35.191.0.0/16) connections to MIG instances
resource "google_compute_firewall" "nw101_allow_http" {
  name    = "nw101-allow-http"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
