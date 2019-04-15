# Create vpc-demo VPC network
#------------------------------
resource "google_compute_network" "vpc_demo" {
  count                   = "${var.count}"
  project                 = "${var.project_prefix}-${count.index+1}"
  name                    = "vpc-demo-${count.index+1}"
  auto_create_subnetworks = false
}

# Create vpc-demo subnetwork
#------------------------------
resource "google_compute_subnetwork" "vpc_demo_subnet1" {
  project                 = "${var.project_prefix}-${count.index+1}"
  count                   = "${var.count}"
  name          = "vpc-demo-subnet1"
  region        = "us-central1"
  network       = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"
  ip_cidr_range = "10.1.1.0/24"
}

resource "google_compute_subnetwork" "vpc_demo_subnet2" {
  project                 = "${var.project_prefix}-${count.index+1}"
  count                   = "${var.count}"
  name          = "vpc-demo-subnet2"
  region        = "us-east1"
  network       = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"
  ip_cidr_range = "10.2.1.0/24"
}

# Create a firewall rule to allow HTTP, 
# SSH and ICMP traffic on vpc-demo VPC
#------------------------------
resource "google_compute_firewall" "vpc_demo_allow_http_ssh_icmp" {
  project                 = "${var.project_prefix}-${count.index+1}"
  count                   = "${var.count}"
  name    = "vpc-demo-allow-http-ssh-icmp"
  network       = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  allow {
    protocol = "icmp"
  }
}

# Create vpc-demo Cloud Router
#------------------------------
resource "google_compute_router" "vpc_demo_router" {
  project                 = "${var.project_prefix}-${count.index+1}"
  count                   = "${var.count}"
  name    = "vpc-demo-router-${count.index+1}"
  network       = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"
  region        = "us-central1"

  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"

    #advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "${element(google_compute_subnetwork.vpc_demo_subnet1.*.ip_cidr_range, count.index)}"
    }
  }
}
