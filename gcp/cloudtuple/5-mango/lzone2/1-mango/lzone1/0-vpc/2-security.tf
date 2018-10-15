resource "google_compute_firewall" "gfe_to_mango" {
  name    = "${var.name}gfe-to-mango"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = ["mig"]
}

resource "google_compute_firewall" "onprem_to_mango" {
  name    = "${var.name}onprem-to-mango"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0","${data.external.onprem_ip.result.ip}"]
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "allow_bastion" {
  name    = "${var.name}allow-bastion"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  source_tags = ["bastion"]
}
