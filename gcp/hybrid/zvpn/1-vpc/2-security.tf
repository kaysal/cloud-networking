
# external

resource "google_compute_firewall" "ssh" {
  name      = "${var.global.prefix}ssh"
  network   = google_compute_network.vpc.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# gfe

resource "google_compute_firewall" "gfe" {
  name        = "${var.global.prefix}gfe"
  network     = google_compute_network.vpc.self_link
  direction   = "INGRESS"
  target_tags = ["gfe"]

  allow {
    protocol = "tcp"
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
}
/*
# l7 ilb proxy range

resource "google_compute_firewall" "l7_ilb_vip" {
  provider      = google-beta
  name          = "${var.global.prefix}l7-ilb-vip"
  network       = google_compute_network.vpc.self_link
  source_ranges = [var.gcp.subnet.proxy]
  direction     = "INGRESS"
  target_tags   = ["l7-ilb-vip"]
  depends_on    = [google_compute_firewall.gfe]

  allow {
    protocol = "tcp"
  }
}*/

# rfc1918

resource "google_compute_firewall" "rfc1918" {
  name      = "${var.global.prefix}rfc1918"
  network   = google_compute_network.vpc.self_link
  direction = "INGRESS"

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}
