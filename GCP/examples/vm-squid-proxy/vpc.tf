# Reserve external IP address
#--------------------------------------
resource "google_compute_address" "squid_proxy_ext_ip" {
  name = "vpn-gw-ext-ip"
  region = "europe-west1"
}

# Create VPC
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------

resource "google_compute_subnetwork" "subnet_eu" {
  name          = "subnet-eu"
  ip_cidr_range = "192.168.20.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west1"
}

# Create firewall rules
#--------------------------------------
resource "google_compute_firewall" "vpc_allow_ssh" {
  name    = "vpc-allow-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

}

resource "google_compute_firewall" "vpc_allow_proxy" {
  name    = "vpc-allow-proxy"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports = ["3128"]
  }

  source_ranges = ["192.168.20.0/24"]
  target_tags = ["proxy"]
}
