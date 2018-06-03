# https://codelabs.developers.google.com/codelabs/cloud-networking-101

provider "google" {
  project     = "${var.project_name}"
  credentials = "${file("${var.credentials_file_path}")}"
}

# Create VPC
#--------------------------------------
resource "google_compute_network" "networking_101" {
  name                    = "networking-101"
  auto_create_subnetworks = "false"
}

# Create Subnets
#--------------------------------------
resource "google_compute_subnetwork" "us_west1_s1" {
  name          = "us-west1-s1"
  ip_cidr_range = "10.10.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "us-west1"
}

resource "google_compute_subnetwork" "us_west1_s2" {
  name          = "us-west1-s2"
  ip_cidr_range = "10.11.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "us-west1"
}

resource "google_compute_subnetwork" "us_east1" {
  name          = "us-east1"
  ip_cidr_range = "10.20.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "us-east1"
}

resource "google_compute_subnetwork" "europe_west1" {
  name          = "europe-west1"
  ip_cidr_range = "10.30.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "europe-west1"
}

resource "google_compute_subnetwork" "asia_east1" {
  name          = "asia-east1"
  ip_cidr_range = "10.40.0.0/16"
  network       = "${google_compute_network.networking_101.self_link}"
  region        = "asia-east1"
}

# Create intsances
#--------------------------------------
resource "google_compute_instance" "w1_vm" {
  name         = "w1-vm"
  machine_type = "n1-standard-1"
  zone         = "us-west1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_west1_s1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "w2_vm" {
  name         = "w2-vm"
  machine_type = "n1-standard-1"
  zone         = "us-west1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_west1_s2.name}"
    address    = "10.11.0.100"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "e1_vm" {
  name         = "e1-vm"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.us_east1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "eu1_vm" {
  name         = "eu1-vm"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-d"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.europe_west1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "asia1_vm" {
  name         = "asia1-vm"
  machine_type = "n1-standard-1"
  zone         = "asia-east1-b"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.asia_east1.name}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

# Create firewall rules
#--------------------------------------
resource "google_compute_firewall" "fw_allow_internal" {
  name    = "${var.name}-allow-internal"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "fw_allow_ssh" {
  name    = "${var.name}-allow-ssh"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "fw_allow_icmp" {
  name    = "${var.name}-allow-icmp"
  network = "${google_compute_network.networking_101.self_link}"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}
