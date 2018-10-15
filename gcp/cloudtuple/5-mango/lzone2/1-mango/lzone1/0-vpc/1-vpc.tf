# host network
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
  routing_mode = "GLOBAL"
}

# service project subnets
#--------------------------------------
# apple service project
resource "google_compute_subnetwork" "10_200_20" {
  name          = "${var.name}10-200-20"
  region        = "europe-west2"
  network       = "${google_compute_network.vpc.self_link}"
  ip_cidr_range = "10.200.20.0/24"
  private_ip_google_access = true
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
