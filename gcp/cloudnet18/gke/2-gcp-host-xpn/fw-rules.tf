# firewall rules - hostnet
#=========================
# allow gfe (130.211.0.0/22 and 35.191.0.0/16)
# connections to MIG instances
resource "google_compute_firewall" "hostnet_allow_web" {
  name    = "${var.name}hostnet-allow-web"
  network = "${google_compute_network.hostnet.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "hostnet_allow_trace" {
  name    = "${var.name}hostnet-allow-trace"
  network = "${google_compute_network.hostnet.self_link}"

  allow {
    protocol = "udp"
    ports = ["33434-33534"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "hostnet_allow_ssh" {
  name    = "${var.name}hostnet-allow-ssh"
  network = "${google_compute_network.hostnet.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# firewall rules - config_gen
#============================
# allow gfe (130.211.0.0/22 and 35.191.0.0/16)
# connections to MIG instances
resource "google_compute_firewall" "configgen_allow_web" {
  name    = "${var.name}configgen-allow-web"
  network = "${google_compute_network.config_gen.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "configgen_allow_trace" {
  name    = "${var.name}configgen-allow-trace"
  network = "${google_compute_network.config_gen.self_link}"

  allow {
    protocol = "udp"
    ports = ["33434-33534"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges  = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "configgen_allow_ssh" {
  name    = "${var.name}configgen-allow-ssh"
  network = "${google_compute_network.config_gen.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
