# Creating a private cluster that uses a custom subnetwork
# Create Cluster Subnets
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet_10_0_4" {
  name          = "${var.name}subnet-10-0-4"
  ip_cidr_range = "10.0.4.0/22"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "europe-west1"
  private_ip_google_access = true

  secondary_ip_range {
    range_name = "${var.name}svc-range"
    ip_cidr_range= "10.0.32.0/20"
  }

  secondary_ip_range {
    range_name = "${var.name}pod-range"
    ip_cidr_range= "10.4.0.0/14"
  }
}
