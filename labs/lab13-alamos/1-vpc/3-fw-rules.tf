
# default
#------------------------------------

resource "google_compute_firewall" "default_allow_mgt" {
  name    = "default-allow-mgt"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "default_allow_rfc1918" {
  name    = "default-allow-rfc1918"
  network = "default"

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}

# alamos
#------------------------------------

resource "google_compute_firewall" "vpc_alamos_allow_mgt" {
  name    = "vpc-alamos-allow-mgt"
  network = google_compute_network.vpc_alamos.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "vpc_alamos_allow_rfc1918" {
  name    = "vpc-alamos-allow-rfc1918"
  network = google_compute_network.vpc_alamos.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}
