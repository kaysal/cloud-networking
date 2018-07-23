# firewall rules
#--------------------------------------
# allow gfe (130.211.0.0/22 and 35.191.0.0/16)
# connections to MIG instances
resource "google_compute_firewall" "allow_web" {
  name    = "${var.name}allow-web"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["vm","web"]
}

resource "google_compute_firewall" "allow_egress" {
  name    = "${var.name}allow-egress"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  target_tags = ["vm"]
}

resource "google_compute_firewall" "allow_trace" {
  name    = "${var.name}allow-trace"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "udp"
    ports = ["33434-33534"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["vm"]
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.name}allow-icmp"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["vm"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.name}allow-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["vm","ssh"]
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "${var.name}allow-rdp"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["vm"]
}
