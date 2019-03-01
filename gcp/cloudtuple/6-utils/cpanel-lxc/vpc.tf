# Create the hosted network.
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "${var.name}cpanel"
  auto_create_subnetworks = "true"
}
