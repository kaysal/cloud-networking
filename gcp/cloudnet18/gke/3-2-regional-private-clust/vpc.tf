# Creating a private cluster that uses a custom subnetwork
# Create Cluster Subnets
#--------------------------------------
resource "google_compute_subnetwork" "k8s_subnet_10_0_8" {
  name          = "${var.name}k8s-subnet-10-0-8"
  ip_cidr_range = "10.0.8.0/22"
  network       = "default"
  region        = "europe-west1"
  private_ip_google_access = true

  secondary_ip_range {
    range_name = "${var.name}svc-range"
    ip_cidr_range= "10.0.48.0/20"
  }

  secondary_ip_range {
    range_name = "${var.name}pod-range"
    ip_cidr_range= "10.8.0.0/14"
  }
}
