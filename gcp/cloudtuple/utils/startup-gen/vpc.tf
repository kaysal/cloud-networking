# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}vpc-prod"
  auto_create_subnetworks = "true"
}
