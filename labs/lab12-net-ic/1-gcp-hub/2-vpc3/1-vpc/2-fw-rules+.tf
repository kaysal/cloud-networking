
# Unhit rule insight with low future hit probability

resource "google_compute_firewall" "rule_1_1" {
  name      = "rule-1-1"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["10.0.1.0/24", ]
  target_tags   = ["http-server", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "rule_1_2" {
  name      = "rule-1-2"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["10.0.2.0/24", ]
  target_tags   = ["http-server", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "rule_1_3" {
  name      = "rule-1-3"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["10.0.3.0/24", ]
  target_tags   = ["http-server", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Unhit rule insight with high future hit probability

resource "google_compute_firewall" "rule_2_1" {
  name      = "rule-2-1"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["10.0.4.0/24", ]
  target_tags   = ["https-server", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "rule_2_2" {
  name      = "rule-2-2"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["10.0.5.0/24", ]
  target_tags   = ["https-server", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "rule_2_3" {
  name      = "rule-2-3"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["10.0.6.0/24", ]
  target_tags   = ["https-server", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Unhit attribute insight with low future hit probability

resource "google_compute_firewall" "rule_3_1" {
  name      = "rule-3-1"
  network   = google_compute_network.vpc3.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8080", "10080", ]
  }

  source_ranges = ["10.0.7.0/24", ]
  target_tags   = ["proxy-server", ]
  priority      = "1000"

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
