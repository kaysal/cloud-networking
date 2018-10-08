#=====================
# dmz network
#=====================
resource "google_compute_firewall" "gfe_to_dmz" {
  name    = "${var.name}gfe-to-dmz"
  network = "${google_compute_network.dmz.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","8080"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
  target_tags = ["natgw"]
}

resource "google_compute_firewall" "onprem_to_dmz" {
  name    = "${var.name}onprem-to-dmz"
  network = "${google_compute_network.dmz.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","8080","22"]
  }

  source_ranges = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}"]
  target_tags = ["natgw","bastion"]
}

resource "google_compute_firewall" "all_dmz" {
  name    = "${var.name}all-dmz"
  network = "${google_compute_network.dmz.self_link}"

  allow {
    protocol = "all"
  }

  source_tags = ["natgw"]
  target_tags = ["natgw"]
}

#=====================
# prod network
#=====================
resource "google_compute_firewall" "onprem_to_prod" {
  name    = "${var.name}onprem-to-prod"
  network = "${google_compute_network.prod.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}"]
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "prod_allow_all" {
  name    = "${var.name}prod-allow-all"
  network = "${google_compute_network.prod.self_link}"

  allow {
    protocol = "all"
  }

  source_ranges = [
    "${google_compute_subnetwork.prod_subnet.ip_cidr_range}",
    "${google_compute_subnetwork.dev_subnet.ip_cidr_range}",
  ]
}

resource "google_compute_firewall" "gfe_to_prod" {
  name    = "${var.name}gfe-to-prod"
  network = "${google_compute_network.prod.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}

#=====================
# dev network
#=====================
resource "google_compute_firewall" "onprem_to_dev" {
  name    = "${var.name}onprem-to-dev"
  network = "${google_compute_network.dev.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0", "${data.external.onprem_ip.result.ip}"]
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "dev_allow_all" {
  name    = "${var.name}dev-allow-all"
  network = "${google_compute_network.dev.self_link}"

  allow {
    protocol = "all"
  }

  source_ranges = [
    "${google_compute_subnetwork.dev_subnet.ip_cidr_range}",
    "${google_compute_subnetwork.prod_subnet.ip_cidr_range}",
  ]
}

resource "google_compute_firewall" "gfe_to_dev" {
  name    = "${var.name}gfe-to-dev"
  network = "${google_compute_network.dev.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}
