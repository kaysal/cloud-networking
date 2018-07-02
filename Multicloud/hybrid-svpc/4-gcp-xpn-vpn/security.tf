# firewall rules
#--------------------------------------
resource "google_compute_firewall" "allow_web" {
  name    = "${var.name}allow-web"
  network = "${data.google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_egress" {
  name    = "${var.name}allow-egress"
  network = "${data.google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "allow_trace" {
  name    = "${var.name}allow-trace"
  network = "${data.google_compute_network.vpc.self_link}"

  allow {
    protocol = "udp"
    ports = ["33434-33534"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.name}allow-icmp"
  network = "${data.google_compute_network.vpc.self_link}"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.name}allow-ssh"
  network = "${data.google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "${var.name}allow-rdp"
  network = "${data.google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}
