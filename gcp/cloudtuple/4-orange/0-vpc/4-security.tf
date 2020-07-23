
# gfe

resource "google_compute_firewall" "gfe_http_ssl_tcp_internal" {
  name    = "${var.main}gfe-http-ssl-tcp-internal"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
  }

  source_ranges = data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal
}

resource "google_compute_firewall" "gfe_nlb" {
  name    = "${var.main}gfe-nlb"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
  }

  source_ranges = data.google_compute_lb_ip_ranges.ranges.network
}

# http

resource "google_compute_firewall" "http_nlb" {
  name    = "${var.main}http-nlb"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports = ["80", "8080", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# ssh

resource "google_compute_firewall" "ssh" {
  name    = "${var.main}ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# rfc1918 & cgn

resource "google_compute_firewall" "rfc1918_cgn_to_gce" {
  name        = "${var.main}rfc1918-cgn"
  network     = google_compute_network.vpc.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "192.168.0.0/16",
    "172.0.0.0/8",
    "100.64.0.0/10",
  ]
}
