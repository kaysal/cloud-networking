# Reserve static IPs for NAT GWs
#--------------------------------------
resource "google_compute_address" "nat_gw_us_ip" {
  name = "nat-gw-us-ip"
  region = "us-central1"
}

resource "google_compute_address" "nat_gw_eu_ip" {
  name = "nat-gw-eu-ip"
  region = "europe-west1"
}

# Create NAT GWs
#--------------------------------------
resource "google_compute_instance" "nat_gw_us" {
  name         = "nat-gw-us"
  machine_type = "n1-standard-1"
  zone         = "us-central1-f"
  tags = ["gw"]
  can_ip_forward = "true"

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.nw102_us.name}"

    access_config {
      nat_ip = "${google_compute_address.nat_gw_us_ip.address}"
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-gw-us.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}

resource "google_compute_instance" "nat_gw_eu" {
  name         = "nat-gw-eu"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"
  tags = ["gw"]
  can_ip_forward = "true"

  boot_disk {
    initialize_params {
      #image = "projects/centos-cloud/global/images/family/centos-7"
      image = "projects/debian-cloud/global/images/family/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.nw102_eu.name}"

    access_config {
      nat_ip = "${google_compute_address.nat_gw_eu_ip.address}"
    }
  }

  metadata {
    ssh-keys = "kayode:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/script-gw-eu.sh")}"

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform.read-only"]
  }
}
