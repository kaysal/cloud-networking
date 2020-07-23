
# vpc

resource "google_compute_network" "ussd_vpc" {
  name                    = "ussd-vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnets

resource "google_compute_subnetwork" "ussd_subnet" {
  name          = "ussd-subnet"
  ip_cidr_range = "10.100.1.0/24"
  region        = "europe-west2"
  network       = google_compute_network.ussd_vpc.self_link
}

# firewall rules

resource "google_compute_firewall" "external" {
  name    = "external"
  network = google_compute_network.ussd_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "icmp" {
  name    = "icmp"
  network = google_compute_network.ussd_vpc.self_link

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}
