# allow ssh to instances
resource "google_compute_firewall" "allow_web" {
  name    = "${var.name}allow-web"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","443","2087"]
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.name}allow-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.name}allow-icmp"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "icmp"
  }
}
