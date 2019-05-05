# firewall rules
#=======================================
resource "google_compute_firewall" "gfe_to_gce" {
  name    = "${var.main}gfe-to-gce"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_ranges = ["${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"]
  target_tags   = ["mig"]
}

resource "google_compute_firewall" "onprem_to_bastion" {
  name    = "${var.main}onprem-to-bastion"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}"]
  target_tags   = ["bastion"]
}

resource "google_compute_firewall" "allow_bastion" {
  name    = "${var.main}allow-bastion"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  source_tags = ["bastion"]
}

resource "google_compute_firewall" "private_to_gce" {
  name    = "${var.main}private-to-gce"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  source_ranges = [
    "10.0.0.0/8",
    "192.168.0.0/16",
    "172.0.0.0/8",
  ]
}

# cgn and rfc1918 space to gce

resource "google_compute_firewall" "cgn_rfc1918_gce" {
  name        = "${var.main}cgn-rfc1918-gce"
  description = "cgn and rfc1918 ip ranges to gce"
  network     = "${google_compute_network.vpc.self_link}"

  #enable_logging = true

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "53", "110"]
  }
  allow {
    protocol = "udp"
    ports    = ["33434-33534", "53"]
  }
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "100.64.0.0/10",
  ]
}
