
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
  target_tags   = [var.global.hc_tag]
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

# trust1

resource "google_compute_firewall" "rfc1918_trust1" {
  name    = "${var.global.prefix}${var.hub.prefix}rfc1918-trust1"
  network = google_compute_network.trust1.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}

resource "google_compute_firewall" "trust1_ext" {
  name    = "${var.global.prefix}${var.hub.prefix}trust1-ext"
  network = google_compute_network.trust1.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "gfe_trust1" {
  name    = "${var.global.prefix}${var.hub.prefix}gfe-trust1"
  network = google_compute_network.trust1.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "8081"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = [var.global.hc_tag]
}

# trust2

resource "google_compute_firewall" "rfc1918_trust2" {
  name    = "${var.global.prefix}${var.hub.prefix}rfc1918-trust2"
  network = google_compute_network.trust2.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}

resource "google_compute_firewall" "trust2_ext" {
  name    = "${var.global.prefix}${var.hub.prefix}trust2-ext"
  network = google_compute_network.trust2.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "gfe_trust2" {
  name    = "${var.global.prefix}${var.hub.prefix}gfe-trust2"
  network = google_compute_network.trust2.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "8081"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = [var.global.hc_tag]
}
