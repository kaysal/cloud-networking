resource "google_compute_firewall" "www_firewall_network_lb" {
  name    = "${var.name}www-firewall-network-lb"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports = ["22","80"]
  }

  allow {
    protocol = "icmp"
  }

  target_tags = ["lb-tag"]
}
