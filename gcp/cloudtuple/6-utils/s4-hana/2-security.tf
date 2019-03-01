# allow ssh to instances
resource "google_compute_firewall" "allow_web" {
  name    = "${var.name}allow-web"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }
}

resource "google_compute_firewall" "allow_all_vpc" {
  name    = "${var.name}allow-all-vpc"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  target_tags = ["vm"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.name}allow-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["${data.external.onprem_ip.result.ip}"]
}
