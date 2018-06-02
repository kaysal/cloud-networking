# https://cloud.google.com/compute/docs/load-balancing/http/content-based-example

provider "google" {
  region      = "${var.region}"
  project     = "${var.project_name}"
  credentials = "${file("${var.credentials_file_path}")}"
  zone        = "${var.region_zone}"
}

# Create VPC
#--------------------------------------
resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "subnet_1" {
  name          = "subnet-1"
  ip_cidr_range = "10.10.0.0/16"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "${var.region}"
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = "subnet-2"
  ip_cidr_range = "192.168.10.0/24"
  network       = "${google_compute_network.vpc.self_link}"
  region        = "${var.region}"
}

# Create intsances
#--------------------------------------
resource "google_compute_instance" "instance_1" {
  name         = "instance-1"
  machine_type = "f1-micro"
  tags         = ["http-tag"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-8"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet_1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/install-www.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

resource "google_compute_instance" "instance_2" {
  name         = "instance-2"
  machine_type = "f1-micro"
  tags         = ["http-tag"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-8"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet_2.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/install-video.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}


# Create firewall rules
#--------------------------------------
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal-only"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "all"
  }

  source_service_accounts  = ["${var.source_service_accounts}"]
}

resource "google_compute_firewall" "allow_external_ssh" {
  name    = "allow-external-ssh"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges  = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_external_http" {
  name    = "allow-external-http"
  network = "${google_compute_network.vpc.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges  = ["0.0.0.0/0"]
}
