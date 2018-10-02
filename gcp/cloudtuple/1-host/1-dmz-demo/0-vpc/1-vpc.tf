# Create networks
#--------------------------------------
resource "google_compute_network" "dmz" {
  name                    = "${var.name}dmz"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "prod" {
  name                    = "${var.name}prod"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "dev" {
  name                    = "${var.name}dev"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "dmz_subnet" {
  name          = "${var.name}dmz-subnet"
  ip_cidr_range = "10.0.0.0/24"
  network       = "${google_compute_network.dmz.self_link}"
  region        = "europe-west1"
  enable_flow_logs = true
}

resource "google_compute_subnetwork" "prod_subnet" {
  name          = "${var.name}prod-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = "${google_compute_network.prod.self_link}"
  region        = "europe-west1"
  enable_flow_logs = true
}

resource "google_compute_subnetwork" "dev_subnet" {
  name          = "${var.name}dev-subnet"
  ip_cidr_range = "10.0.2.0/24"
  network       = "${google_compute_network.dev.self_link}"
  region        = "europe-west1"
  enable_flow_logs = true
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
