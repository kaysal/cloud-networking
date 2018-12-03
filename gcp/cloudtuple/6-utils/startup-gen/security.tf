# allow ssh to instances
resource "google_compute_firewall" "allow_web" {
  name    = "${var.name}allow-web"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }
}
