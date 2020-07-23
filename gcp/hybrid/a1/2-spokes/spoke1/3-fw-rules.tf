
# spoke1

resource "google_compute_firewall" "external" {
  name    = "${var.global.prefix}${var.spoke1.prefix}external"
  network = google_compute_network.spoke1_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "iap" {
  name    = "${var.global.prefix}${var.spoke1.prefix}iap"
  network = google_compute_network.spoke1_vpc.self_link

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_firewall" "rfc1918" {
  name    = "${var.global.prefix}${var.spoke1.prefix}rfc1918"
  network = google_compute_network.spoke1_vpc.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}
