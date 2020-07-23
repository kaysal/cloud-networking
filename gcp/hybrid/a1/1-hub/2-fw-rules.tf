
# untrust

resource "google_compute_firewall" "ssh_untrust" {
  name    = "${var.global.prefix}${var.hub.prefix}ssh-untrust"
  network = google_compute_network.untrust.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "gfe_untrust" {
  name    = "${var.global.prefix}${var.hub.prefix}gfe-untrust"
  network = google_compute_network.untrust.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "8081"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = [var.hub.untrust.tag.hc]
}


resource "google_compute_firewall" "rfc1918_untrust" {
  name    = "${var.global.prefix}${var.hub.prefix}rfc1918-untrust"
  network = google_compute_network.untrust.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}

# trust

resource "google_compute_firewall" "all_trust1" {
  name    = "${var.global.prefix}${var.hub.prefix}all-trust1"
  network = google_compute_network.trust1.self_link

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "all_trust2" {
  name    = "${var.global.prefix}${var.hub.prefix}all-trust2"
  network = google_compute_network.trust2.self_link

  allow {
    protocol = "all"
  }
}
