# dependency checker
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

# VPN GW external IP
#--------------------------------------
resource "google_compute_address" "gateway_ip" {
  count   = "${var.users}"
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  name    = "vpc-demo-gw-ip"
  region  = "us-central1"
}

# Create vpc-demo VPC network
#------------------------------
resource "google_compute_network" "vpc_demo" {
  count                   = "${var.users}"
  project                 = "${var.rand}-user${count.index+1}-${var.suffix}"
  name                    = "vpc-demo-${count.index+1}"
  auto_create_subnetworks = false
  depends_on              = ["null_resource.dependency_getter"]
}

# Create vpc-demo subnetwork
#------------------------------
resource "google_compute_subnetwork" "vpc_demo_subnet1" {
  project       = "${var.rand}-user${count.index+1}-${var.suffix}"
  count         = "${var.users}"
  name          = "vpc-demo-subnet1"
  region        = "us-central1"
  network       = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"
  ip_cidr_range = "10.1.1.0/24"
}

resource "google_compute_subnetwork" "vpc_demo_subnet2" {
  project       = "${var.rand}-user${count.index+1}-${var.suffix}"
  count         = "${var.users}"
  name          = "vpc-demo-subnet2"
  region        = "us-central1"
  network       = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"
  ip_cidr_range = "10.2.1.0/24"
}

resource "google_compute_subnetwork" "vpc_demo_subnet3" {
  project       = "${var.rand}-user${count.index+1}-${var.suffix}"
  count         = "${var.users}"
  name          = "vpc-demo-subnet3"
  region        = "us-east1"
  network       = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"
  ip_cidr_range = "10.3.1.0/24"
}

# Create a firewall rule to allow HTTP,
# SSH and ICMP traffic on vpc-demo VPC
#------------------------------
resource "google_compute_firewall" "vpc_demo_allow_http_ssh_icmp" {
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  count   = "${var.users}"
  name    = "vpc-demo-allow-http-ssh-icmp"
  network = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"

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
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  count   = "${var.users}"
  name    = "vpc-demo-router"
  network = "${element(google_compute_network.vpc_demo.*.self_link, count.index)}"
  region  = "us-central1"

  bgp {
    asn            = "${var.asn}"
    advertise_mode = "CUSTOM"

    #advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "${element(google_compute_subnetwork.vpc_demo_subnet1.*.ip_cidr_range, count.index)}"
    }
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = ["google_compute_router.vpc_demo_router"]
}

output "depended_on" {
  value = "${null_resource.dependency_setter.id}"
}
