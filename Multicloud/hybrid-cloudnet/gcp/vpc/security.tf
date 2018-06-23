# firewall rules
#--------------------------------------
resource "google_compute_firewall" "allow_web" {
  name    = "allow-web"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_egress" {
  name    = "allow-egress"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "allow_trace" {
  name    = "allow-trace"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "udp"
    ports = ["33434-33534"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}
