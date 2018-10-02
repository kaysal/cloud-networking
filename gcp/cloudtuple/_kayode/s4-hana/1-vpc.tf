# host network
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
}

# service project subnets
#--------------------------------------
resource "google_compute_subnetwork" "eu_w2_192_168_1" {
  name          = "${var.name}eu-w2-192-168-1"
  region        = "europe-west2"
  network       = "${google_compute_network.vpc.self_link}"
  ip_cidr_range = "192.168.1.0/24"
  enable_flow_logs = true

  secondary_ip_range {
    range_name = "hana-containers"
    ip_cidr_range= "192.168.2.0/24"
  }
}

# HANA external IP
#--------------------------------------
resource "google_compute_address" "hana1_ip" {
  name = "${var.name}hana1-ip"
  region = "europe-west2"
}

resource "google_compute_address" "hana2_ip" {
  name = "${var.name}hana2-ip"
  region = "europe-west2"
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
