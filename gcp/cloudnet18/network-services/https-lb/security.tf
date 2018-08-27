# firewall rules for dmz vpc
#-------------------------------
resource "google_compute_firewall" "dmz_allow_http" {
  name    = "${var.name}dmz-allow-http"
  network = "${google_compute_network.dmz.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80","8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["natgw"]
}

resource "google_compute_firewall" "dmz_allow_ssh" {
  name    = "${var.name}dmz-allow-ssh"
  network = "${google_compute_network.dmz.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["natgw","ssh"]
}

# firewall rules for prod vpc
#-------------------------------
resource "google_compute_firewall" "prod_allow_ssh" {
  name    = "${var.name}prod-allow-ssh"
  network = "${google_compute_network.prod.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "prod_allow_all" {
  name    = "${var.name}prod-allow-all"
  network = "${google_compute_network.prod.self_link}"

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.1.0/24","10.0.2.0/24"]
}

# allow gfe (130.211.0.0/22 and 35.191.0.0/16)
# health check probes to prod mig instances
resource "google_compute_firewall" "prod_health_checks" {
  name    = "${var.name}prod-health-checks"
  network = "${google_compute_network.prod.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}


# firewall rules for dev networks
#-------------------------------
resource "google_compute_firewall" "dev_allow_ssh" {
  name    = "${var.name}dev-allow-ssh"
  network = "${google_compute_network.dev.self_link}"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "dev_allow_all" {
  name    = "${var.name}dev-allow-all"
  network = "${google_compute_network.dev.self_link}"

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.1.0/24","10.0.2.0/24"]
}

# allow gfe (130.211.0.0/22 and 35.191.0.0/16)
# health check probes to dev mig instances
resource "google_compute_firewall" "dev_health_checks" {
  name    = "${var.name}dev-health-checks"
  network = "${google_compute_network.dev.self_link}"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}
