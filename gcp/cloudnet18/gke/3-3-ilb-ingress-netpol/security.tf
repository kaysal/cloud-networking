# firewall rules
#--------------------------------------
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.name}allow-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  target_tags = ["vm"]

  source_ranges = ["0.0.0.0/0"]
}
