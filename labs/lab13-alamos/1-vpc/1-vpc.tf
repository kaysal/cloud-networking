
# network
#------------------------------------

resource "google_compute_network" "vpc_alamos" {
  name                    = "vpc-alamos"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnets
#------------------------------------

# eu

resource "google_compute_subnetwork" "jump_subnet" {
  name          = "jump-subnet"
  ip_cidr_range = "10.100.1.0/24"
  region        = "europe-west2"
  network       = google_compute_network.vpc_alamos.self_link
}
