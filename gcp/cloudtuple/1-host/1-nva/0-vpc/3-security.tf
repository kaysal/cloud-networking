# Management Network
#=====================
// Adding access to MANGEMENT from internet
resource "google_compute_firewall" "allow_mgmt" {
  name    = "${var.nva}allow-mgmt"
  network = "${google_compute_network.mgt.self_link}"

  allow {
    /*
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  allow {
    protocol = "icmp"
    */
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
}

# Untrust Network
#=====================
// Allow INBOUND http(s) traffic from GCLB proxy to Untrust
// Untrust PAN interface will only receive traffic from GCLB
resource "google_compute_firewall" "allow_inbound" {
  name    = "${var.nva}allow-inbound"
  network = "${google_compute_network.untrust.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80","8080"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

# Trust Network
#=====================
// Allow all INBOUND and OUTBOUND traffic in Trust VPC
resource "google_compute_firewall" "allow_all_trust" {
  name    = "${var.nva}allow-all-trust"
  network = "${google_compute_network.trust.self_link}"

  allow {
    protocol = "all"
  }
}
