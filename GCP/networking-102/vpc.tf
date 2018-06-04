
# Create VPC
#--------------------------------------
resource "google_compute_network" "nw102" {
  name                    = "nw102"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "nw102_us" {
  name          = "nw102-us"
  ip_cidr_range = "192.168.10.0/24"
  network       = "${google_compute_network.nw102.self_link}"
  region        = "us-central1"
}

resource "google_compute_subnetwork" "nw102_eu" {
  name          = "nw102-eu"
  ip_cidr_range = "192.168.20.0/24"
  network       = "${google_compute_network.nw102.self_link}"
  region        = "europe-west1"
}

# Create firewall rules
#--------------------------------------
resource "google_compute_firewall" "nw102_allow_internal" {
  name    = "nw102-allow-internal"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["192.168.10.0/24","192.168.20.0/24"]
}

resource "google_compute_firewall" "nw102_allow_ssh" {
  name    = "nw102-allow-ssh"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_route" "nw102_nat_us" {
  name        = "nw102-nat-us"
  dest_range  = "0.0.0.0/0"
  network     = "${google_compute_network.nw102.name}"
  next_hop_instance = "${google_compute_instance.nat_gw_us.name}"
  next_hop_instance_zone = "us-central1-f"
  priority    = 800
  tags = ["nat-us"]
}

resource "google_compute_route" "nw102_nat_eu" {
  name        = "nw102-nat-eu"
  dest_range  = "0.0.0.0/0"
  network     = "${google_compute_network.nw102.name}"
  next_hop_instance = "${google_compute_instance.nat_gw_eu.name}"
  next_hop_instance_zone = "europe-west1-c"
  priority    = 800
  tags = ["nat-eu"]
}
