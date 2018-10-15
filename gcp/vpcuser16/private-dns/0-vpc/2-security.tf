resource "google_compute_firewall" "gfe_to_prod" {
  name    = "${var.name}gfe-to-prod"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","8080"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = ["mig"]
}

resource "google_compute_firewall" "onprem_to_prod" {
  name    = "${var.name}onprem-to-prod"
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

resource "google_compute_firewall" "aws_to_gce" {
  name    = "${var.name}aws-to-gce"
  description = "allowed connections from aws to gce"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","8080","443","53"]
  }

  allow {
    protocol = "udp"
    ports = ["33434-33534","53"]
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }

  source_ranges = ["172.16.10.0/24","172.18.10.0/24"]
  target_tags = ["mig","bastion"]

}
