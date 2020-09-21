
# network
#------------------------------------

resource "google_compute_network" "vpc3" {
  name                    = "vpc3"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# subnets
#------------------------------------

resource "google_compute_subnetwork" "range1" {
  provider      = google-beta
  name          = "range1"
  ip_cidr_range = var.hub.vpc3.us.cidr.range1
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range2" {
  name          = "range2"
  ip_cidr_range = var.hub.vpc3.us.cidr.range2
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range3" {
  name          = "range3"
  ip_cidr_range = var.hub.vpc3.us.cidr.range3
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range4" {
  name          = "range4"
  ip_cidr_range = var.hub.vpc3.us.cidr.range4
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range5" {
  name          = "range5"
  ip_cidr_range = var.hub.vpc3.us.cidr.range5
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range6" {
  name          = "range6"
  ip_cidr_range = var.hub.vpc3.us.cidr.range6
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range7" {
  name          = "range7"
  ip_cidr_range = var.hub.vpc3.us.cidr.range7
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range8" {
  name          = "range8"
  ip_cidr_range = var.hub.vpc3.us.cidr.range8
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range9" {
  name          = "range9"
  ip_cidr_range = var.hub.vpc3.us.cidr.range9
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range10" {
  name          = "range10"
  ip_cidr_range = var.hub.vpc3.us.cidr.range10
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}


# extra subnets
#------------------------------------

resource "google_compute_subnetwork" "range0_x" {
  name          = "range0-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range0
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range1_x" {
  name          = "range1-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range1
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range2_x" {
  name          = "range2-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range2
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range3_x" {
  name          = "range3-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range3
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range4_x" {
  name          = "range4-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range4
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range5_x" {
  name          = "range5-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range5
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range6_x" {
  name          = "range6-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range6
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

resource "google_compute_subnetwork" "range7_x" {
  name          = "range7-x"
  ip_cidr_range = var.hub.vpc3.us.cidr2.range7
  region        = var.hub.vpc3.us.region
  network       = google_compute_network.vpc3.self_link
}

# public ip address

resource "google_compute_address" "vm9_pulbic_ip" {
  name   = "vm9-public-ip"
  region = var.hub.vpc3.us.region
}

resource "google_compute_address" "vm10_pulbic_ip" {
  name   = "vm10-public-ip"
  region = var.hub.vpc3.us.region
}
