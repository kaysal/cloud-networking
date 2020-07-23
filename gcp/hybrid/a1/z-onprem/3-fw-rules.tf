
# onprem

resource "google_compute_firewall" "external" {
  name    = "${var.global.prefix}${var.onprem.prefix}external"
  network = google_compute_network.onprem.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "rfc1918" {
  name    = "${var.global.prefix}${var.onprem.prefix}rfc1918"
  network = google_compute_network.onprem.self_link

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}

resource "google_compute_firewall" "dns_egress_proxy" {
  project = var.project_id_onprem
  name    = "${var.global.prefix}${var.onprem.prefix}dns-egress-proxy"
  network = google_compute_network.onprem.self_link

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  source_ranges = ["35.199.192.0/19"]
}
