# dependency checker
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

# Create vpc-saas VPC network
#------------------------------
resource "google_compute_network" "vpc_saas" {
  count                   = "${var.users}"
  project                 = "${var.rand}-user${count.index+1}-${var.suffix}"
  name                    = "vpc-saas-${count.index+1}"
  auto_create_subnetworks = false

  depends_on = [
    "null_resource.dependency_getter",
  ]
}

# Create vpc-saas subnetwork
#------------------------------
resource "google_compute_subnetwork" "vpc_saas_subnet1" {
  project       = "${var.rand}-user${count.index+1}-${var.suffix}"
  count         = "${var.users}"
  name          = "vpc-saas-subnet1"
  region        = "us-central1"
  network       = "${element(google_compute_network.vpc_saas.*.self_link, count.index)}"
  ip_cidr_range = "192.168.1.0/24"
}

# Create a firewall rule to allow HTTP,
# SSH and ICMP traffic on vpc-saas VPC
#------------------------------
resource "google_compute_firewall" "vpc_saas_allow_http_ssh_icmp" {
  project = "${var.rand}-user${count.index+1}-${var.suffix}"
  count   = "${var.users}"
  name    = "vpc-saas-allow-http-ssh-icmp"
  network = "${element(google_compute_network.vpc_saas.*.self_link, count.index)}"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  allow {
    protocol = "icmp"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = ["google_compute_subnetwork.vpc_saas_subnet1"]
}

output "depended_on" {
  value = "${null_resource.dependency_setter.id}"
}
