# Reserve external IP address
#--------------------------------------
resource "google_compute_address" "web_ext_ip" {
  name = "web-ext-ip"
  region = "us-central1"
}

resource "google_compute_address" "new_web_ext_ip" {
  name = "new-web-ext-ip"
  region = "europe-west1"
}

# Create VPC
#--------------------------------------
resource "google_compute_network" "nw102" {
  name                    = "nw102"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "nw102_us" {
  name          = "nw102-us"
  ip_cidr_range = "192.168.10.0/24"
  network       = "${google_compute_network.nw102.self_link}"
  region        = "us-central1"
}

resource "google_compute_subnetwork" "nw102_eu" {
  name          = "nw102-eu"
  ip_cidr_range = "192.168.20.0/24"
  network       = "${google_compute_network.nw102.self_link}"
  region        = "europe-west1"
}

# Create firewall rules
#--------------------------------------
resource "google_compute_firewall" "nw102_allow_app" {
  name    = "nw102-allow-app"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22","80"]
  }

  source_tags = ["gw","app"]
  target_tags = ["app"]
}

resource "google_compute_firewall" "nw102_allow_web" {
  name    = "nw102-allow-web"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22","80"]
  }

  source_tags = ["gw","web"]
  target_tags = ["web"]
}

resource "google_compute_firewall" "nw102_allow_egress" {
  name    = "nw102-allow-egress"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","443"]
  }

  source_tags = ["app","web"]
  target_tags = ["gw"]
}

resource "google_compute_firewall" "nw102_allow_traceroute" {
  name    = "nw102-allow-traceroute"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "udp"
    ports = ["33434-33534"]
  }

  source_ranges = ["192.168.10.0/24","192.168.20.0/24"]
  target_tags = ["gw"]
}

resource "google_compute_firewall" "nw102_allow_ssh" {
  name    = "nw102-allow-ssh"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["${var.local_public_ip}"]
}

resource "google_compute_firewall" "nw102_allow_ext" {
  name    = "nw102-allow-ext"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  target_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "default_allow_http_server" {
  name    = "default-allow-http-server"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  target_tags = ["http-server"]
}

# firewall to allow external ip access through nat-gw-us
resource "google_compute_firewall" "nw102_allow_on_prem_alt" {
  name    = "nw102-allow-on-prem-alt"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  target_tags = ["gw"]
  source_ranges = ["192.168.0.0/19"]
}

# firewall to allow external ip access through nat-gw-us
resource "google_compute_firewall" "nw102_allow_proxy" {
  name    = "nw102-allow-proxy"
  network = "${google_compute_network.nw102.self_link}"

  allow {
    protocol = "tcp"
    ports = ["3128"]
  }

  target_tags = ["gw"]
  source_ranges = ["192.168.20.0/24"]
}

# Routes
#--------------------------------------
resource "google_compute_route" "nw102_nat_us" {
  name        = "nw102-nat-us"
  dest_range  = "0.0.0.0/0"
  network     = "${google_compute_network.nw102.name}"
  next_hop_instance = "${google_compute_instance.nat_gw_us.name}"
  next_hop_instance_zone = "us-central1-f"
  priority    = 800
  tags = ["nat-us"]
}

resource "google_compute_route" "nw102_nat_eu" {
  name        = "nw102-nat-eu"
  dest_range  = "0.0.0.0/0"
  network     = "${google_compute_network.nw102.name}"
  next_hop_instance = "${google_compute_instance.nat_gw_eu.name}"
  next_hop_instance_zone = "europe-west1-c"
  priority    = 800
  tags = ["nat-eu"]
}

#static route for alias IP address on nat-gw-us
resource "google_compute_route" "nw102_192_168_30_11" {
  name        = "nw102-192-168-30-11"
  dest_range  = "192.168.30.11/32"
  network     = "${google_compute_network.nw102.name}"
  next_hop_instance = "${google_compute_instance.nat_gw_us.name}"
  next_hop_instance_zone = "us-central1-f"
}

# Create target pool (target instance) for forwarding rule
#--------------------------------------
resource "google_compute_target_pool" "web_target" {
  name = "web-target"
  region = "us-central1"
  instances = ["us-central1-f/nat-node-w-us"]
}

resource "google_compute_target_pool" "new_web_target" {
  name = "new-web-target"
  region = "europe-west1"
  instances = ["europe-west1-c/nat-node-w-eu"]
}

# Forwarding rule for external access to web tier
#--------------------------------------
resource "google_compute_forwarding_rule" "web_ext" {
  name       = "web-ext"
  ip_protocol = "TCP"
  ip_address = "${google_compute_address.web_ext_ip.address}"
  region = "us-central1"
  target     = "${google_compute_target_pool.web_target.self_link}"
  port_range = "80"
}

resource "google_compute_forwarding_rule" "new_web_ext" {
  name       = "new-web-ext"
  ip_protocol = "TCP"
  ip_address = "${google_compute_address.new_web_ext_ip.address}"
  region = "europe-west1"
  target     = "${google_compute_target_pool.new_web_target.self_link}"
  port_range = "80"
}
