# Create a firewall rule to allow all internal traffic within the network.
resource "google_compute_firewall" "demo_allow_internal" {
  name    = "${var.name}demo-allow-internal"
  network = "${google_compute_network.vpc_demo.self_link}"

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports = ["0-65535"]
  }

  source_ranges = ["10.1.1.0/24","10.1.2.0/24"]
}

# Create firewall rule to allow ssh, rdp, http, icmp from anywhere
resource "google_compute_firewall" "demo_allow_ssh_rdp_http_icmp" {
  name    = "${var.name}demo-allow-ssh-rdp-http-icmp"
  network = "${google_compute_network.vpc_demo.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22","3389","80"]
  }

  allow {
    protocol = "icmp"
  }
}

# allow gfe (130.211.0.0/22 and 35.191.0.0/16)
# health check probes to dev mig instances
resource "google_compute_firewall" "demo_allow_health_check" {
  name    = "${var.name}demo-allow-health-check"
  network = "${google_compute_network.vpc_demo.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}
