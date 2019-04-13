
# Create vpc-demo VPC network
resource "google_compute_network" "vpc_demo" {
  project = "${var.project_id}"
  name                    = "vpc-demo"
  auto_create_subnetworks = false
}

# Create vpc-demo subnetwork
resource "google_compute_subnetwork" "vpc_demo_subnet1" {
  name          = "vpc-demo-subnet1"
  region        = "us-central1"
  network       = "${google_compute_network.vpc_demo.self_link}"
  ip_cidr_range = "10.1.1.0/24"
}

resource "google_compute_subnetwork" "vpc_demo_subnet2" {
  name          = "vpc-demo-subnet2"
  region        = "us-east1"
  network       = "${google_compute_network.vpc_demo.self_link}"
  ip_cidr_range = "10.2.1.0/24"
}

# Create a firewall rule to allow HTTP, SSH and ICMP traffic on vpc-demo VPC
resource "google_compute_firewall" "vpc_demo_allow_http_ssh_icmp" {
  name    = "vpc-demo-allow-http-ssh-icmp"
  network = "${google_compute_network.vpc_demo.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  allow {
    protocol = "icmp"
  }
}

# Create vpc-demo cloud router
resource "google_compute_router" "vpc_demo_router" {
  name    = "vpc-demo-router"
  network = "${google_compute_network.vpc_demo.name}"
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    #advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "${google_compute_subnetwork.vpc_demo_subnet1.ip_cidr_range}"
    }
  }
}
